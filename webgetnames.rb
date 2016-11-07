require 'net/http'
require 'nokogiri'
require 'sinatra'
require 'json'
def getnames(generator,type)
 if type == 'default' or type.nil?
	 uri = URI.parse("http://www.seventhsanctum.com/generate.php?Genname=" + generator + "&selGenCount=20")
 else
	 uri = URI.parse("http://www.seventhsanctum.com/generate.php?Genname=" + generator + "&selGenCount=20&selGenType=" + type)
 end
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
get '/getnames/:generator' do
 names = getnames(params['generator'],'default')
 return names
end
get '/getnames/:generator/:type' do
 names = getnames(params['generator'],params['type'])
 return names
end
