class Census
  module Ohio
    class AbsenteeMailMapper < FileMapper
      def county_voter_id
        @county_voter_id ||= sanitize_county_voter_id(18)
      end

      def ballot_status
        sanitize_row_input(36)
      end

      def date_requested
        sanitize_row_input(33).tap do |raw_date|
          return nil if raw_date.blank?
          return Time.strptime(raw_date, "%m/%d/%Y %l:%M:%S %p")
        end
      end

      def date_returned
        sanitize_row_input(34).tap do |raw_date|
          return nil if raw_date.blank?
          return Date.strptime(raw_date, "%m/%d/%Y")
        end
      end

      def date_mailed
        sanitize_row_input(16).tap do |raw_date|
          return nil if raw_date.blank?
          return Date.strptime(raw_date, "%m/%d/%Y")
        end
      end
    end
  end
end
