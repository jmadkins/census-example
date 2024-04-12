class Census
  module Processors
    class BaseProcessor
      def initialize(census:, mapper:)
        @census = census
        @mapper = mapper
      end

      def self.execute(census:, mapper:)
        ActiveRecord::Base.transaction do
          new(census: census, mapper: mapper).execute
        end
      end

      private

      def execute
        raise NotImplementedError
      end
    end
  end
end
