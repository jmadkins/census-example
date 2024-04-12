class Census
  module Operations
    class UpsertLocality
      def initialize(address, localities)
        @address = address
        @localities = localities
      end

      def self.invoke(address, localities)
        new(address, localities).invoke
      end

      def invoke
        return if address_localities.empty?

        AddressLocality.insert_all address_localities, unique_by: :index_address_localities_uniqueness
      end

      private

      def address_localities
        @address_localities ||= @localities.map do |locality_id|
          {
            address_id: @address.id,
            locality_id: locality_id
          }
        end
      end
    end
  end
end
