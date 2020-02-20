require "httparty"
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d049d79760cb4b7aac606da81e683918"
news = HTTParty.get(url).parsed_response.to_hash

puts news["articles"][0]["title"]
puts news["articles"][0]["description"]
puts news["articles"][0]["url"]

for zebra in news["articles"]
    puts zebra["title"]
    puts zebra["description"]
    puts zebra["url"]
end