class OpmlImport
  def initialize(data)
    @data = data
  end

  def run
    feeds = OpmlParser.new.parse_feeds(@data).map do |l| 
      Feed.create(title: l[:name], url: l[:url])
    end

    feeds
  end
end