class Census
  module Mappers
    class Mailchimp < FileMapper
      def email
        sanitize_row_input(0)
      end

      def first_name
        sanitize_row_input(1)
      end

      def last_name
        sanitize_row_input(2)
      end

      def attributes
        @attributes ||= {
          first_name: first_name,
          last_name: last_name,
          email: email
        }
      end
    end
  end
end
