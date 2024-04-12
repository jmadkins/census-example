class Census
  module Ohio
    class LocalitiesMapper < FileMapper
      def initialize(row)
        @row = row
      end

      def values
        @values ||= {
          appeals_court: sanitize_row_input(32),
          career_center: sanitize_row_input(27),
          congress: sanitize_row_input(31),
          county: sanitize_row_input(1),
          county_court: sanitize_row_input(30),
          education_service_center: sanitize_row_input(33),
          house: sanitize_row_input(41),
          library: sanitize_row_input(35),
          municipal_court: sanitize_row_input(37),
          municipality: sanitize_row_input(28),
          precinct_code: sanitize_row_input(39),
          precinct_name: sanitize_row_input(38),
          school: school_code,
          senate: sanitize_row_input(42),
          state: Census::Ohio.code,
          state_education: sanitize_row_input(40),
          township: sanitize_township_name(sanitize_row_input(43)),
          village: sanitize_row_input(44),
          ward: sanitize_row_input(45)
        }
      end

      private

      def school_code
        @school_code ||= [
          sanitize_row_input(29), # city school
          sanitize_row_input(34), # exempted village school
          sanitize_row_input(36) # local school
        ].compact.first
      end
    end
  end
end
