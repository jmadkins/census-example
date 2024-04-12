class Census
  module Processors
    class Voter < BaseProcessor
      def execute
        return if digests_match?

        @voter = if registration.present?
          Operations::UpdateVoter.invoke @mapper, registration
        else
          Operations::CreateVoter.invoke @mapper
        end

        Operations::UpsertVoterHistory.invoke @voter, @mapper.voter_history
        Operations::UpsertVoterAddresses.invoke @voter, @mapper

        true
      end

      private

      def registration
        @registration ||= VoterRegistration
          .find_voter_in_state(
            state_id: @mapper.state_locality.id,
            state_voter_id: @mapper.registration_attributes[:state_voter_id]
          )
      end

      def digests_match?
        return false if registration.nil? || @census.force_reprocess?

        @mapper.digest == registration.person.census_digest
      end
    end
  end
end
