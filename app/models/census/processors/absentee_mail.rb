class Census
  module Processors
    class AbsenteeMail < BaseProcessor
      def execute
        return unless voter_registration

        request = AbsenteeBallot.find_or_initialize_by(
          person_id: voter_registration.person_id,
          election_id: election_id
        )
        request.requested_at = @mapper.date_requested
        request.mailed_at = @mapper.date_mailed
        request.returned_at = @mapper.date_returned
        request.status = if request.returned_at?
          if @mapper.ballot_status == "VAL"
            :accepted
          elsif @mapper.ballot_status == "REJECTED"
            :rejected
          else
            :returned
          end
        elsif request.mailed_at?
          :mailed
        else
          :requested
        end
        request.save!
      end

      private

      def voter_registration
        @voter_registration ||= VoterRegistration
          .includes(:person)
          .find_by(county_voter_id: @mapper.county_voter_id)
      end

      def election_id
        Election.locate("G", "11/07/2023").id
      end
    end
  end
end
