class Census
  module Ohio
    class AbsenteeInPersonMapper < FileMapper
      def county_voter_id
        @county_voter_id ||= sanitize_county_voter_id(18)
      end

      def date_voted
        sanitize_row_input(16).tap do |raw_date|
          return nil if raw_date.blank?
          return Date.strptime(raw_date, "%m/%d/%Y")
        end
      end
    end
  end
end
