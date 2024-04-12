require "csv"

module CensusRow::Parser
  extend ActiveSupport::Concern

  def parsed_values
    case census.delimiter
    when "csv"
      CSV.parse(row_data)[0]
    when "space", "txt"
      row_data.split(" ")
    when "tab"
      row_data.split("\t")
    else
      raise "Unsupported delimiter: #{census.delimiter}"
    end
  end
end
