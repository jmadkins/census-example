class Census
  module Arkansas
    class Mapper < FileMapper
      DATE_FORMAT = "%m/%d/%Y"

      def personal_attributes
        @personal_attributes ||= {
          salutation: sanitize_row_input(7),
          last_name: sanitize_row_input(8),
          first_name: sanitize_row_input(9),
          middle_name: sanitize_row_input(10),
          suffix: sanitize_row_input(11),
          date_of_birth: Date.strptime(sanitize_row_input(5), DATE_FORMAT)
        }
      end

      def voting_address?
        voting_address_attributes[:street].present?
      end

      def voting_address_attributes
        @voting_address_attributes ||= {
          street: sanitize_input(voting_address_street),
          street2: sanitize_input(voting_address_street2),
          city: sanitize_row_input(20),
          state: sanitize_row_input(21),
          zip_code: assemble_zip_code(sanitize_row_input(22), sanitize_row_input(23)),
          country: voting_address_street.present? ? "USA" : nil
        }
      end

      def mailing_address?
        mailing_address_attributes[:street].present?
      end

      def mailing_address_attributes
        @mailing_address_attributes ||= {
          street: sanitize_row_input(25),
          street2: sanitize_row_input(26),
          city: sanitize_row_input(29),
          state: sanitize_row_input(30),
          zip_code: assemble_zip_code(sanitize_row_input(31), sanitize_row_input(32)),
          country: sanitize_input("#{sanitize_row_input(27)} #{sanitize_row_input(28)}").presence || "USA",
          geostatus: "mailing"
        }
      end

      def registration_attributes
        @registration_attributes ||= {
          state_voter_id: sanitize_row_input(2),
          county_voter_id: sanitize_row_input(1),
          date_registered: Date.strptime(sanitize_row_input(6), DATE_FORMAT),
          voter_status: status_abbreviation(sanitize_row_input(3)),
          political_party: sanitize_row_input(37).presence || "O",
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

      def status_abbreviation(input)
        input.nil? ? "I" : input[0]
      end

      def voting_address_street
        @voting_address_street ||= [
          "#{sanitize_row_input(12)}#{sanitize_row_input(13)}".strip,
          sanitize_row_input(14),
          sanitize_row_input(15),
          sanitize_row_input(16),
          sanitize_row_input(17)
        ].reject(&:blank?).join(" ")
      end

      def voting_address_street2
        @voting_address_street2 ||= [
          sanitize_row_input(18),
          sanitize_row_input(19)
        ].reject(&:blank?).join(" ")
      end
    end
  end
end
