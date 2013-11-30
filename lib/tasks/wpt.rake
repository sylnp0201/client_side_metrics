require 'sqlite3'

namespace :wpt do
  desc 'run webpatetest tests'
  task :run => :environment do
    options = {}
    options[:test] = ENV['TEST_MODE'].present? ? true : false
    options[:proxy] = ENV['PROXY'] || nil
    options[:runs] = ENV['RUNS'].present? ? ENV['RUNS'].to_i : 1
    Webpagetest::WptRunner.new(options).run
  end

  desc 'transfer existing data from sqlite3 db to the current rails app'
  task :transfer => :environment do
    from = ENV['FROM'] || "#{Rails.root}/db/webpagetest.db"
    db = SQLite3::Database.new(from)
    db.results_as_hash = true
    rows = db.execute( "select test_id, result from tests" )
    rows.each do |row|
      test_id = row['test_id']
      new_test = WptTest.find_by_test_id(test_id)
      next if new_test.present?
      WptTest.create!(test_id: test_id, xml: row['result'])
    end
    Webpagetest::TestResultFactory.convert_data
  end
end