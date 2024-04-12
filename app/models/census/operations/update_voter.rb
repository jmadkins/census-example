class Census
  module Operations
    class UpdateVoter
      def initialize(mapper, registration)
        @mapper = mapper
        @registration = registration
      end

      def self.invoke(mapper, registration)
        new(mapper, registration).invoke
      end

      def invoke
        @registration.person.update(personal_attributes)

        if registration_changed?
          Census::Operations::CreateVoterRegistration.invoke @mapper, @registration.person
        elsif registration_missing_locality?
          update_registration_missing_localities
        end

        @registration.person
      end

      private

      # TODO: record special note if switched_parties
      def registration_changed?
        switched_parties? || voter_status_changed? || moved_counties?
      end

      def switched_parties?
        @registration.political_party_id != @mapper.political_party_id
      end

      def voter_status_changed?
        @registration.voter_status_id != @mapper.voter_status_id
      end

      def moved_counties?
        @registration.county_voter_id != @mapper.registration_attributes[:county_voter_id]
      end

      # TODO: retire this after Ohio has been reprocessed a full-time
      def registration_missing_locality?
        @registration.state_locality_id.nil? || @registration.county_locality_id.nil?
      end

      def update_registration_missing_localities
        @registration.update!(
          state_locality_id: @mapper.state_locality.id,
          county_locality_id: @mapper.county_locality.id
        )
      end

      def personal_attributes
        @mapper.personal_attributes.merge(census_digest: @mapper.digest)
      end
    end
  end
end
