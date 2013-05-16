require 'spec_helper'

describe FeedImport do
  describe '#initialize' do
    it 'raises error on invalid argument' do
      expect { FeedImport.new('foo') }.to raise_error ArgumentError, "Feed instance required"
    end

    it 'does not raise error if Feed instance provided' do
      expect { FeedImport.new(Feed.new) }.not_to raise_error ArgumentError
    end
  end

  describe '#run' do
    let(:feed)   { Fabricate(:feed) }
    let(:import) { FeedImport.new(feed) }

    it 'creates a new feed' do
      pending
    end
  end
end