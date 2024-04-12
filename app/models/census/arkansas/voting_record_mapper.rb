class Census
  module Arkansas
    class VotingRecordMapper < FileMapper
      def initialize(row, state_locality)
        @row = row
        @state_locality = state_locality
      end

      def history
        @history ||= Census::Arkansas.elections.map do |attrs|
          # if the voter participated in the election, the `sos_election_id_column` will have a value.
          # we do nothing with the value, but it represents the id of the elction from the sos.
          return nil if sanitize_row_input(attrs[:sos_election_id_column]).blank?

          @state_locality
            .elections
            .find_sole_by(day: attrs[:day], election_type: attrs[:election_type])
            .voting_records
            .build(vote: sanitize_row_input(attrs[:vote_column]).presence)
        end.compact!
      end
    end
  end
end
