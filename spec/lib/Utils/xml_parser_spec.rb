require 'spec_helper'

describe Utils::XmlParser do

  let(:xml) { %Q|<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<response>\n<statusCode>200</statusCode>\n<statusText>Ok</statusText>\n<data>\n<testId>131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be</testId>\n<ownerKey>4acd944ed93f456537c341ed6173656213f312cb</ownerKey>\n<xmlUrl>http://www.webpagetest.org/xmlResult/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</xmlUrl>\n<userUrl>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</userUrl>\n<summaryCSV>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/page_data.csv</summaryCSV>\n<detailCSV>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/requests.csv</detailCSV>\n<jsonUrl>http://www.webpagetest.org/jsonResult.php?test=131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</jsonUrl>\n</data>\n</response>\n| }
  let(:parser) { Utils::XmlParser.new xml }

  it 'parses xml' do
    parser.status_code.should == '200'
    parser.test_id.should == '131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be'
  end

end