class Census
  module Operations
    class UpsertVoterAddresses
      def initialize(person, mapper)
        @person = person
        @mapper = mapper
        @person_addresses = []
      end

      def self.invoke(person, mapper)
        new(person, mapper).invoke
      end

      def invoke
        upsert_voting_address if @mapper.voting_address?
        upsert_mailing_address if @mapper.mailing_address?
        bulk_insert_person_addresses if @person_addresses.any?

        true
      end

      private

      def upsert_voting_address
        Operations::UpsertAddress.invoke(@mapper.voting_address_attributes).tap do |address|
          Operations::UpsertLocality.invoke address, locality_ids

          unless @person.voting_address_id == address.id
            @person.update!(voting_address_id: address.id)
            @person_addresses << {address_type: :voting, address_id: address.id}
          end
        end
      end

      def upsert_mailing_address
        Operations::UpsertAddress.invoke(@mapper.mailing_address_attributes).tap do |address|
          current_mailing = @person.current_addresses.where(address_type: :mailing).first
          unless current_mailing&.address_id == address.id
            @person_addresses << {address_type: :mailing, address_id: address.id}
          end
        end
      end

      def locality_ids
        @locality_ids ||= Census::LocalityAdapter.new(
          state_id: @mapper.state_locality.id,
          county_id: @mapper.county_locality.id,
          localities_hash: @mapper.localities
        ).ids
      end

      def bulk_insert_person_addresses
        @person.person_addresses
          .create_with(created_at: Time.current, updated_at: Time.current)
          .insert_all(@person_addresses)
      end
    end
  end
end
