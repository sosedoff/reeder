class OpmlImport
  def initialize(data, user)
    @data = File.read(data) rescue nil
    @data = data if @data.nil?
    @user = user
  end

  def run
    feeds = OpmlParser.new.parse_feeds(@data).map do |l| 
      @user.feeds.create(title: l[:name], url: l[:url])
    end

    feeds
  end
end