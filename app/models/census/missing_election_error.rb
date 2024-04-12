class Census::MissingElectionError < StandardError
  def initialize(type, date)
    super("Type #{type} on #{date}")
  end
end
