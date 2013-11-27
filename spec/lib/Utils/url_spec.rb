require 'spec_helper'

describe Utils::Url do
  describe '##hash_to_query' do
    it 'converts a hash to a query string' do
      Utils::Url.hash_to_query({'a' => '1', 'b' => '2'}).should == 'a=1&b=2'
    end
  end

  describe '##query_to_hash' do
    it 'converts a hash to a query string' do
      Utils::Url.query_to_hash('a=1&b=2').should == {'a' => '1', 'b' => '2'}
    end
  end

end