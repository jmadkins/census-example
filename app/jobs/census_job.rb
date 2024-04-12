# Takes a Census ID and enqueues all of the CensusBatches into a Sidekiq batch.
class CensusJob < ApplicationJob
  def perform(id)
    Census.find(id).process_now
  end

  def on_complete(status, options)
    census = Census.find(options["uid"])
    if status.failures == 0
      SlackBot.fyi "Census #{census.id} has finished processing."
      census.update(status: "finished")
    else
      SlackBot.fyi "Census #{census.id} has finished processing with some failures."
      census.update(status: "errored")
    end
  end
end
