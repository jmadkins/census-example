class Census
  module Operations
    class CreateVoterRegistration
      def initialize(mapper, voter)
        @mapper = mapper
        @voter = voter
      end

      def self.invoke(mapper, voter)
        new(mapper, voter).invoke
      end

      def invoke
        @voter.active_voter_registration_id = VoterRegistration.create!(
          person_id: @voter.id,
          county_voter_id: @mapper.registration_attributes[:county_voter_id],
          state_voter_id: @mapper.registration_attributes[:state_voter_id],
          date_registered: @mapper.registration_attributes[:date_registered],
          political_party_id: @mapper.political_party_id,
          voter_status_id: @mapper.voter_status_id,
          state_locality_id: @mapper.state_locality.id,
          county_locality_id: @mapper.county_locality.id
        ).id
        @voter.save!
      end
    end
  end
end
