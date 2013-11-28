require 'spec_helper'

describe TestMetaDatum do
  describe '##sample_url' do
    before do
      TestMetaDatum.create!({page: 'homepage', test_url: 'www.bloomberg.com'})
      TestMetaDatum.create!({page: 'article', test_url: 'www.bloomberg.com/news/foo.html'})
    end
    it 'returns a sample url of the given page type' do
      TestMetaDatum.sample_url('article').should == 'www.bloomberg.com/news/foo.html'
    end
  end
end
