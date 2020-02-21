require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter the Dark Sky API key 
ForecastIO.api_key = "2bd468baa60dba0ff2e90b73af836c08"

# enter the news API key 
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d049d79760cb4b7aac606da81e683918"
news = HTTParty.get(url).parsed_response.to_hash


#The first route is used to capture a location from the user and submit that location to a second route
get "/" do
  view "ask"
end


#The second route which displays the news
get "/news" do
    
    #Use the Geocoder API to turn the location (e.g. "Chicago") into a set of lat/long coordinates
    results = Geocoder.search(params["location"])
    lat_lng = results.first.coordinates
    lat = lat_lng[0]
    lng = lat_lng[1]

    #Send the lat/long coordinates to the Dark Sky API and retrieve the result
    forecast = ForecastIO.forecast(lat,lng).to_hash

    @location = params["location"]
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]

    @array_weather = forecast["daily"]["data"]

    @array_news = news["articles"]
    
    
    view "news"
end


    
