class Webpagetest::TestResultFactory
  attr_reader :parser
  attr_reader :wpt_test
  def initialize(wpt_test)
    @wpt_test = wpt_test
    @parser = Webpagetest::WptParser.new(wpt_test.xml)
  end

  def build
    first_view = build_view('first_view')
    repeat_view = build_view('repeat_view')
    summary = build_summary
    if first_view.present?
      first_view.save!
      summary.first_view = first_view
    end
    if repeat_view.present?
      repeat_view.save!
      summary.repeat_view = repeat_view
    end
    summary.wpt_test = wpt_test
    summary.save!
  end

  def build_summary
    TestMetaDatum.new(parser.summary)
  end

  def build_view(view_name)
    view = parser.send(view_name.to_sym)
    return nil if view.blank?
    TestViewDatum.new(view)
  end

  def self.convert_data
    unprocessed = WptTest.unprocessed
    unprocessed.each do |wpt_test|
      factory = Webpagetest::TestResultFactory.new(wpt_test)
      factory.build
    end
  end

end