require 'nokogiri'
require 'open-uri'
require "benchmark"

system("clear")

SITES = ["http://www.cbc.ca", "http://www.google.ca", "http://www.nbc.com", "http://www.abc.com", "http://www.cbs.com", "http://www.fox.com"]

unthreaded_time = Benchmark.measure do
  puts "STARTING UNTHREADED JOB..."
  puts ""
  SITES.each do |site|
    page = Nokogiri::HTML(open(site))
    puts "Retrieved page #{page.title}..."
    sleep(2)
  end
end

puts "Elapsed time unthreaded: #{unthreaded_time}"

puts ""
puts "-------------------------------------------"

threaded_time = Benchmark.measure do
  puts "STARTING THREADED JOB..."
  puts ""
  threads = []
  SITES.each do |site|
    threads << Thread.new {
      page = Nokogiri::HTML(open(site))
      puts "Retrieved page #{page.title}..."
      sleep(2)
    }
  end
  threads.each(&:join)
end

puts "Elapsed time threaded: #{threaded_time}"


