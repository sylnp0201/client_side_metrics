namespace :wpt do
  desc "run webpatetest tests"
  task :run => :environment do
    p "Starting running page performance tests on webpagetest"
    options = {}
    options[:test] = ENV['TEST_MODE'].present? ? true : false
    options[:proxy] = ENV['PROXY'] || nil
    options[:runs] = ENV['RUNS'].present? ? ENV['RUNS'].to_i : 1
    Webpagetest::WptRunner.new(options).run
  end
end