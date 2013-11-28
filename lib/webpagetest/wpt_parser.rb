class Webpagetest::WptParser
  attr_reader :data

  def initialize(xml)
    @data = Hash.from_xml(xml)
  end

  def summary
    s = data['response']['data']
    location, browser = loc_bro(s['location'])
    {
      test_id:  s['testId'],
      summary:  s['summary'],
      test_url: s['testUrl'],
      page: page_type(s['testUrl']),
      location: location,
      browser:  browser,
      connectivity: s['connectivity'],
      ran_at:   Time.parse(s['completed']),
      runs:     s['runs'].to_i
    }
  end

  def first_view
    detailed_view('firstView')
  end

  def repeat_view
    detailed_view('repeatView')
  end

  def page_type(url)
    url =~ /\/news\// ? 'article' : 'homepage'
  end

  def loc_bro(lb)
    lb.split(/[:_]/)
  end

  private

  def detailed_view(view = 'firstView')
    s = data['response']['data']['average'][view]
    result = {
      load_time: s['loadTime'],
      first_byte: s['TTFB'],
      bytes_in: s['bytesIn'],
      bytes_in_doc: s['bytesInDoc'],
      request: s['requests'],
      requests_doc: s['requestsDoc'],
      fully_loaded: s['fullyLoaded'],
      doc_time: s['docTime'],
      dom_elements: s['domElements'],
      title_time: s['titleTime']
    }
    result.each_pair { |key, val| result[key] = val.to_i }
  end
end