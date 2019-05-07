#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'
webgetnames = ENV['WEBGETNAMES']
if webgetnames.nil?
 puts 'set environment variable WEBGETNAMES to URL of web service'
 exit 1 
end
if ARGV[0].nil?
 generator = 'superheronameorg'
else
 generator = ARGV[0]
 if generator == 'silly'
  generator = 'sillyhero'
 end
 if generator == 'quickname'
  type = ARGV[1]
 end
 if generator == 'female'
  generator = 'quickname'
  type = 'FNAME'
 end
 if generator == 'male'
  generator = 'quickname'
  type = "MNAME"
 end
end
if type.nil?
 uri = URI.parse(webgetnames + '/' + generator)
else
 uri = URI.parse(webgetnames + '/' + generator + "/" + type)
end
request = Net::HTTP::Get.new(uri.request_uri)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
response = http.request(request)
names = JSON.parse(response.body)
puts names
