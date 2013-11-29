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
    result[:first_view] = time_series_data('first_view', options['fields'], result)
    result[:repeat_view] = time_series_data('repeat_view', options['fields'], result)

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

  def time_series_data(view, fields, query_options)
    data = TestMetaDatum.joins(view.to_sym)
    .select(associate_fields(fields))
    .where("ran_at>:since AND location=:location AND browser=:browser AND page=:page", query_options)
    .order(ran_at: :asc)
    .group('test_meta_data.test_id')
    data.map { |row| [row['ran_at'], row] }
  end

  def associate_fields(fields)
    af = []
    fields.each_with_index do |ele, idx|
      af[idx] = "test_meta_data.#{ele}" if TestMetaDatum.column_names.include?(ele)
      af[idx] = "test_view_data.#{ele}" if TestViewDatum.column_names.include?(ele)
    end
    af
  end
end
