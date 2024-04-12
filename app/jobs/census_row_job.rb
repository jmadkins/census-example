# Takes a CensusRow id and processes it
class CensusRowJob < ApplicationJob
  sidekiq_options queue: :census, retry: 3

  def perform(id)
    return unless valid_within_batch?
    row = CensusRow.find(id)
    row.process_now
  rescue Census::MissingElectionError
    # If the election is missing, we can't process the row.
    Rails.logger.warn "CensusRowJob: Census::MissingElectionError for #{id}"
    row.finish_with_error!
  end
end
