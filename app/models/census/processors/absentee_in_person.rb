class Census
  module Processors
    class AbsenteeInPerson < BaseProcessor
      def execute
        return unless voter_registration

        request = AbsenteeBallot.find_or_initialize_by(
          person_id: voter_registration.person_id,
          election_id: election_id
        )
        return if request.status == :in_person

        request.returned_at = @mapper.date_voted
        request.status = :in_person
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
