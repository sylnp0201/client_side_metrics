class Utils::XmlParser
  attr_reader :xml

  def initialize(str)
    @xml = Nokogiri.XML(str)
  end

  def status_code
    xml.xpath('//statusCode')[0].text
  end

  def test_id
    xml.xpath('//testId')[0].text
  end
end