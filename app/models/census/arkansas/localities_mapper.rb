class Census
  module Arkansas
    class LocalitiesMapper < FileMapper
      def initialize(row)
        @row = row
      end

      def values
        @values ||= {
          appeals_court: sanitize_row_input(47),
          congress: sanitize_row_input(44),
          county: sanitize_row_input(0),
          district_court: sanitize_row_input(50),
          education_service_center: sanitize_row_input(61), # technical school
          fire: sanitize_row_input(62),
          house: sanitize_row_input(46),
          judicial: sanitize_row_input(48),
          judicial_subdivision: sanitize_row_input(49),
          justice_peace: sanitize_row_input(52),
          levee: sanitize_row_input(57),
          municipality: sanitize_row_input(55),
          precinct_code: sanitize_row_input(35),
          precinct_name: precinct_name,
          school: school_code,
          senate: sanitize_row_input(45),
          state: Census::Arkansas.code,
          township: sanitize_township_name(sanitize_row_input(51)),
          ward: sanitize_row_input(56),
          water_board: sanitize_row_input(43)
        }
      end

      private

      def precinct_name
        sanitize_input "#{sanitize_row_input(33)}-#{sanitize_row_input(36)}"
      end

      def school_code
        @school_code ||= [
          sanitize_row_input(53), # school district
          sanitize_row_input(54) # school district zone
        ].compact.first
      end
    end
  end
end
