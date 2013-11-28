require 'spec_helper'

describe WptTest do
  describe '##unprocessed' do
    before do
      WptTest.create!({test_id: '1'})
      WptTest.create!({test_id: '2'})
      WptTest.create!({test_id: '3'})
      TestMetaDatum.create!({test_id: '1'})
      TestMetaDatum.create!({test_id: '2'})
    end
    it 'returns all unprocessed tests' do
      WptTest.unprocessed.size.should == 1
      WptTest.unprocessed[0].test_id.should == '3'
    end
  end
end
