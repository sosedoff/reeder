require 'spec_helper'

describe OpmlParser do
  describe '#parse_feeds' do
    it 'returns empty array on invalid xml' do
      expect(OpmlParser.new.parse_feeds('foobar')).to eq []
    end

    it 'returns an array of feed links' do
      result = OpmlParser.new.parse_feeds(fixture('opml.xml'))

      expect(result).to be_an Array
      expect(result[0][:name]).to eq 'A Fresh Cup'
      expect(result[0][:url]).to eq 'http://afreshcup.com/home/rss.xml'
    end
  end
end