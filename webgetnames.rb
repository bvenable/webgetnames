require 'net/http'
require 'nokogiri'
require 'sinatra'
require 'json'
def getnames(type)
 uri = URI.parse("http://www.seventhsanctum.com/generate.php?Genname=" + type)
 response = Net::HTTP.get_response(uri)
 page = Nokogiri::HTML(response.body)
 a = Array.new
 ary1 = page.css("div[class='GeneratorResultPrimeBG']")
 ary2 = page.css("div[class='GeneratorResultSecondaryBG']")
 ary1.each do |e|
  a << e.text
 end
 ary2.each do |e|
  a << e.text
 end
 return a.to_json
end
get '/getnames/:type' do
 names = getnames(params['type'])
 return names
end
