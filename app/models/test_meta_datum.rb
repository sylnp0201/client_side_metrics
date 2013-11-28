class TestMetaDatum < ActiveRecord::Base
  belongs_to :first_view, class_name: 'TestViewDatum'
  belongs_to :repeat_view, class_name: 'TestViewDatum'
  belongs_to :wpt_test, class_name: 'WptTest', foreign_key: 'test_id'

  def self.sample_url(page_type)
    rec = where(page: page_type).order(ran_at: :desc).limit(1)[0]
    rec.present? ? rec.test_url : nil
  end
end
