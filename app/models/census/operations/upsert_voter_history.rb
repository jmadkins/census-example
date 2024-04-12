class Census
  module Operations
    class UpsertVoterHistory
      def initialize(person, voting_records)
        @person = person
        @voting_records = voting_records
      end

      def self.invoke(person, voting_records)
        new(person, voting_records).invoke
      end

      def invoke
        return if importable_records.empty?

        VotingRecord.insert_all importable_records, unique_by: :index_voting_records_uniqueness
      end

      private

      def importable_records
        @importable_records ||= @voting_records.map do |vr|
          {
            person_id: @person.id,
            election_id: vr.election_id,
            vote: vr.vote
          }
        end
      end
    end
  end
end
