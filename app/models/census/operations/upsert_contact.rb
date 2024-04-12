class Census
  module Operations
    class UpsertContact
      def initialize(attributes)
        @attributes = attributes
      end

      def self.invoke(attributes)
        new(attributes).invoke
      end

      def invoke
        Contact.match_and_upsert(match_params)
      end

      def match_params
        Contact::AutoMatcher::Params.new(
          universe_id: Current.universe.id,
          first_name: @attributes[:first_name],
          last_name: @attributes[:last_name],
          email: @attributes[:email],
          phone: nil,
          street: nil,
          city: nil,
          zip_code: nil
        )
      end
    end
  end
end
