module Census::Processable
  extend ActiveSupport::Concern

  included do
    validates :processor, presence: true
    validates :mapping, presence: true
  end

  def prep_for_reprocessing
    reset_census_rows
    batch_pending_rows
    update(status: "processing")
  end

  def processor_class
    processor.constantize
  end

  def mapping_class
    mapping.constantize
  end

  def process_now
    return if census_batches.size.zero?

    batch = find_or_create_sidekiq_batch
    batch.jobs do
      census_batches.in_batches do |rows|
        CensusBatchJob.perform_bulk rows.pluck(:id).zip
      end
    end

    if sidekiq_batch_id.blank?
      true
    else
      update!(sidekiq_batch_id: batch.bid)
    end
  end

  def process_later
    CensusJob.perform_async id
  end

  private

  def reset_census_rows
    census_rows.where.not(status: "finished").update_all(status: "pending", status_details: nil, census_batch_id: nil)
  end

  def pending_census_rows
    census_rows.where(status: "pending", census_batch_id: nil)
  end

  def batch_pending_rows
    pending_census_rows.in_batches do |pending_rows|
      census_batches.create.tap do |census_batch|
        pending_rows.update_all(census_batch_id: census_batch.id)
      end
    end
  end

  def find_or_create_sidekiq_batch
    return Sidekiq::Batch.new(sidekiq_batch_id) if sidekiq_batch_id.present?

    batch = Sidekiq::Batch.new
    batch.description = "#{model_name} ##{id}"
    batch.on(:complete, CensusJob, "uid" => id)
    batch
  rescue Sidekiq::Batch::NoSuchBatch
    update!(sidekiq_batch_id: nil)
    retry
  end
end
