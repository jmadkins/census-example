class Census::FileIngestor
  def initialize(blob)
    @blob = blob
    @content_type = blob.content_type
  end

  def each
    @blob.open do |tempfile|
      case @content_type
      when "application/zip"
        require "zip"

        Zip::File.open(tempfile) do |zip_file|
          zip_file.each do |entry|
            yield entry.get_input_stream
          end
        end
      when "application/gzip", "application/x-gzip"
        require "zlib"

        yield Zlib::GzipReader.open(tempfile)
      else
        # this file requires no special handling
        yield tempfile
      end
    end
  end
end
