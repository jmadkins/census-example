class Census
  module Ohio
    class VotingRecordMapper < FileMapper
      def initialize(row, state_locality)
        @row = row
        @state_locality = state_locality
      end

      def history
        @history ||= Census::Ohio.elections.map do |attrs|
          # a `nil` value in the `vote_column` means the voter did NOT vote in that election -- return a nil
          # primary elections value will be the voters party abbreviation
          # general elections value will be an `X` if the voter voted in that election but we will save it as `nil`
          raw_vote = sanitize_row_input(attrs[:vote_column])
          return nil if raw_vote.nil?

          @state_locality
            .elections
            .find_sole_by(day: attrs[:day], election_type: attrs[:election_type])
            .voting_records
            .build(vote: (raw_vote == "X") ? nil : raw_vote)
        end.compact!
      end
    end
  end
end
