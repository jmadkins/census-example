# Takes a Census ID and ingests/imports the raw data
class CensusIngestJob < ApplicationJob
  # This originally was not designed to run on the census queue, however now that the
  # census queue machines are provisoned with more RAM, it should be run there.
  sidekiq_options queue: :census

  def perform(id)
    census = Census.find(id)
    Current.universe = census.universe

    census.ingest_now
    census.reload
    census.process_later
  end
end
