class Census::FileMapper
  def initialize(raw_data:, parsed_values:)
    @raw_data = raw_data
    @row = parsed_values
  end

  def digest
    @digest ||= Digest::SHA256.hexdigest(@raw_data)
  end

  def voter_status_id
    @voter_status_id ||= VoterStatus.locate_with_cache(registration_attributes[:voter_status]).id
  end

  def political_party_id
    @political_party_id ||= PoliticalParty.locate_with_cache(registration_attributes[:political_party]).id
  end

  def registration_attributes
    raise NotImplementedError
  end

  private

  def sanitize_row_input(position)
    sanitize_input @row[position]
  end

  def sanitize_input(value)
    return if value.nil? || value == ""

    value.strip
  end

  def assemble_zip_code(five_digit, four_digit)
    "#{five_digit}#{four_digit}".strip
  end

  def sanitize_township_name(input)
    return if input.nil?

    input.gsub("TOWNSHIP OF ", "").gsub("TOWNSHP", "").strip
  end

  # not every locality stores the county voter id the same way
  # so we standardize it based on the ohio secretary of state's
  def sanitize_county_voter_id(position, length = 9)
    sanitize_row_input(position).to_s.rjust(length, "0")
  end
end
