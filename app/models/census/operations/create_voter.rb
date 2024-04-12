class Census
  module Operations
    class CreateVoter
      def initialize(mapper)
        @mapper = mapper
      end

      def self.invoke(mapper)
        new(mapper).invoke
      end

      def invoke
        new_voter = Person.new(personal_attributes)
        new_voter.save!

        Census::Operations::CreateVoterRegistration.invoke @mapper, new_voter

        new_voter
      end

      private

      def personal_attributes
        @mapper.personal_attributes.merge(public: true, census_digest: @mapper.digest)
      end
    end
  end
end
