class TestMetaDatum < ActiveRecord::Base
  belongs_to :first_view, class_name: 'TestViewDatum'
  belongs_to :repeat_view, class_name: 'TestViewDatum'
  belongs_to :wpt_test, class_name: 'WptTest', foreign_key: 'test_id'

  def self.sample_url(page_type)
    rec = where(page: page_type).order(ran_at: :desc).limit(1)[0]
    rec.present? ? rec.test_url : nil
  end

  def self.recent_records(view, query_params)
    joins(view)
    .select(self.associate_fields(query_params[:fields]))
    .where("ran_at>:start_time AND location=:location AND browser=:browser AND page=:page", query_params)
    .order(ran_at: :asc)
    .group('test_meta_data.test_id')
  end

  def self.twenty_four_hour_summary(view, query_params)
    options = query_params.merge({start_time: (Time.now - 1.day)})
    rows = self.recent_records(view, options)
    summary = {}
    num = rows.length
    return {} if num == 0
    options[:fields].each do |field|
      total = 0
      rows.each do |row|
        total += row[field] if row[field]
      end
      avg = total.to_f/num
      summary[field] = avg.round
    end
    summary
  end

  def self.time_series_data(view, fields, query_options)
    data = joins(view)
    .select(self.associate_fields(fields))
    .where("ran_at>:since AND location=:location AND browser=:browser AND page=:page", query_options)
    .order(ran_at: :asc)
    .group('test_meta_data.test_id')
    data.map { |row| [row['ran_at'], row] }
  end

  def self.associate_fields(fields = [])
    af = []
    fields.each_with_index do |ele, idx|
      af[idx] = "test_meta_data.#{ele}" if TestMetaDatum.column_names.include?(ele)
      af[idx] = "test_view_data.#{ele}" if TestViewDatum.column_names.include?(ele)
    end
    af
  end

end
