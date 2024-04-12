# Adds all the rows within a CensusBatch to Sidekiq and then deletes the batch.
class CensusBatchJob < ApplicationJob
  # not processed on the census queue so that we can load more census batches while a census is running
  sidekiq_options retry: 3

  def perform(census_batch_id)
    return unless valid_within_batch?

    census_batch = CensusBatch.find(census_batch_id)

    batch.jobs do
      census_batch.rows.in_batches do |rows|
        CensusRowJob.perform_bulk rows.pluck(:id).zip
      end
    end

    census_batch.destroy!
  end
end
