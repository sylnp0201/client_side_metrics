class ReportController < ApplicationController

  DEFAULT_LOCATION = 'Dulles'
  DEFAULT_BROWSER  = 'IE8'
  DEFAULT_FIELDS = ['load_time', 'first_byte', 'start_render']
  PERMANENT_FIELDS = ['test_id', 'ran_at']
  DEFAULT_PAGE = 'homepage'

  def index
    options = set_default_options(params)
    result = {
      since: options['since'],
      browser: options['browser'],
      location: options['location'],
      page: options['page'],
      url: TestMetaDatum.sample_url(options['page']),
      fields: options['fields'].select { |f| !PERMANENT_FIELDS.include?(f) }
    }
    result[:first_view] = TestMetaDatum.time_series_data(:first_view, options['fields'], result)
    result[:repeat_view] = TestMetaDatum.time_series_data(:repeat_view, options['fields'], result)
    result[:tf_summary] = tf_summary_data(result)
    respond_to do |format|
      format.html do
        @result = result.to_json
        render
      end
      format.json { render json: result.to_json }
    end
  end

  def set_default_options(params = {})
    ops = params.reverse_merge({
      'since' => "#{(Date.today-30).strftime("%Y-%m-%d")}",
      'browser' => DEFAULT_BROWSER,
      'page' => DEFAULT_PAGE,
      'location' => DEFAULT_LOCATION
    })
    ops['fields'] = parse_query_fields(params['fields'])
    ops
  end

  def parse_query_fields(str)
    arr = str.present? ? str.split(',') : DEFAULT_FIELDS.dup
    PERMANENT_FIELDS.each { |f| arr << f unless arr.include?(f) }
    arr
  end

  def tf_summary_data(query_options)
    {
      fields: query_options[:fields],
      views: ['first_view', 'repeat_view'],
      first_view: TestMetaDatum.twenty_four_hour_summary(:first_view, query_options),
      repeat_view: TestMetaDatum.twenty_four_hour_summary(:repeat_view, query_options)
    }
  end
end
