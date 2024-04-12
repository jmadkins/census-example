class Census
  module Ohio
    class Mapper < FileMapper
      DATE_FORMAT = "%Y-%m-%d"

      def personal_attributes
        @personal_attributes ||= {
          last_name: sanitize_row_input(3),
          first_name: sanitize_row_input(4),
          middle_name: sanitize_row_input(5),
          suffix: sanitize_row_input(6),
          date_of_birth: Date.strptime(sanitize_row_input(7), DATE_FORMAT)
        }
      end

      def voting_address?
        voting_address_attributes[:street].present?
      end

      def voting_address_attributes
        @voting_address_attributes ||= {
          street: sanitize_row_input(11),
          street2: sanitize_row_input(12),
          city: sanitize_row_input(13),
          state: sanitize_row_input(14),
          zip_code: assemble_zip_code(sanitize_row_input(15), sanitize_row_input(16)),
          country: sanitize_row_input(17) || "USA"
        }
      end

      def mailing_address?
        mailing_address_attributes[:street].present?
      end

      def mailing_address_attributes
        @mailing_address_attributes ||= {
          street: sanitize_row_input(19),
          street2: sanitize_row_input(20),
          city: sanitize_row_input(21),
          state: sanitize_row_input(22),
          zip_code: assemble_zip_code(sanitize_row_input(23), sanitize_row_input(24)),
          country: sanitize_row_input(25) || "USA",
          geostatus: "mailing"
        }
      end

      def registration_attributes
        @registration_attributes ||= {
          state_voter_id: sanitize_row_input(0),
          county_voter_id: sanitize_row_input(2),
          date_registered: Date.strptime(sanitize_row_input(8), DATE_FORMAT),
          voter_status: status_abbreviation(sanitize_row_input(9)),
          political_party: sanitize_row_input(10).presence || "U",
          county_locality_id: county_locality.id,
          state_locality_id: state_locality.id
        }
      end

      def state_locality
        @state_locality ||= Locality.states.find_sole_by(code: localities[:state])
      end

      def county_locality
        @county_locality ||= state_locality.child_localities.county.find_sole_by(code: localities[:county])
      end

      def localities
        @localities ||= LocalitiesMapper.new(@row).values
      end

      def voter_history
        @voter_history ||= VotingRecordMapper.new(@row, state_locality).history
      end

      private

      # ACTIVE VOTER
      # CONF NON-VOTER
      def status_abbreviation(input)
        input.nil? ? "I" : input[0]
      end
    end
  end
end
