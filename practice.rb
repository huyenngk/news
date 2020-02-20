url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d049d79760cb4b7aac606da81e683918"
news = HTTParty.get(url).parsed_response.to_hash
puts news[:status]