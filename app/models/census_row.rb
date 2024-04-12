# == Schema Information
#
# Table name: census_rows
#
#  id              :bigint           not null, primary key
#  census_id       :bigint           not null
#  row_data        :string           not null
#  status          :string           not null
#  status_details  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  census_batch_id :bigint
#
class CensusRow < ApplicationRecord
  include AASM
  include Parser

  belongs_to :census

  validates :census, :row_data, :status, presence: true

  delegate :mapping_class, :processor_class, to: :census

  aasm column: :status do
    state :pending, initial: true
    state :processing, :errored, :finished

    event :start_processing do
      transitions from: [:pending, :errored], to: :processing
    end

    event :finish_processing do
      transitions from: [:processing, :errored], to: :finished

      after do
        update!(status_details: nil)
      end
    end

    event :finish_with_error do
      transitions from: [:processing, :errored], to: :errored
    end
  end

  def process_now
    return if finished? || processing?

    start_processing!

    processor_class.execute(census: census, mapper: new_mapping_class)

    finish_processing!
  rescue => e
    update(status: "errored", status_details: e.message)
  end

  def process_later
    CensusRowJob.perform_async(id)
  end

  def digest
    Digest::SHA256.hexdigest(row_data)
  end

  private

  def new_mapping_class
    mapping_class.new(raw_data: row_data, parsed_values: parsed_values)
  end
end
