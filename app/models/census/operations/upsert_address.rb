class Census
  module Operations
    class UpsertAddress
      def initialize(attributes)
        @attributes = attributes
      end

      def self.invoke(attributes)
        new(attributes).invoke
      end

      def invoke
        address = Address.locate(
          street: @attributes[:street],
          street2: @attributes[:street2],
          city: @attributes[:city],
          zip_code: @attributes[:zip_code]
        ).first

        return Address.create!(@attributes) if address.nil?

        if address.zip_code.length < @attributes[:zip_code].length
          address.update!(zip_code: @attributes[:zip_code])
        end

        address
      end
    end
  end
end
