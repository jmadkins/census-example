module Census::Ingestable
  extend ActiveSupport::Concern

  DELIMITERS = {
    "Text - Spaces" => "space",
    "Text - Tabs" => "tab",
    "CSV" => "csv"
  }.freeze

  included do
    has_one_attached :source_file, dependent: :destroy, service: :census
    validates :delimiter, inclusion: {in: DELIMITERS.values}, presence: true
  end

  def ingest_now
    return unless analyzing?

    Census::FileIngestor.new(source_file.blob).each do |file|
      bulk_insert_file(file)
    end

    update!(status: "preparing", row_count: census_rows.size)
  end

  def ingest_later
    if compressed_source_file?
      SlackBot.fyi "Census #{id} is a compressed file and ready to be processed manually."
    else
      CensusIngestJob.perform_async(id)
    end
  end

  private

  def bulk_insert_file(file)
    file.drop(number_of_rows_to_drop_from_source_file).each_slice(CensusBatch.size) do |chunk|
      current_time = Time.current
      census_batch = census_batches.create
      rows_data = chunk.map do |raw_row|
        {
          census_id: id,
          census_batch_id: census_batch.id,
          row_data: raw_row.encode("UTF-8", invalid: :replace, undef: :replace),
          status: "pending",
          created_at: current_time,
          updated_at: current_time
        }
      end

      CensusRow.insert_all rows_data
    end
  end

  def number_of_rows_to_drop_from_source_file
    has_header_row? ? 1 : 0
  end

  # if content type is zip or gzip, then we need to extract the file
  def compressed_source_file?
    source_file.blob.content_type.in?(%w[application/zip application/gzip application/x-gzip])
  end
end
