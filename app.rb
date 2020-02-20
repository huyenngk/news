require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "2bd468baa60dba0ff2e90b73af836c08"



get "/" do
  view "ask"
end

get "/news" do
    
    #Weather forecast
    results = Geocoder.search(params["location"])
    lat_lng = results.first.coordinates
    lat = lat_lng[0]
    lng = lat_lng[1]

    
    forecast = ForecastIO.forecast(lat,lng).to_hash

    # current weather forecast 
    current_temperature = forecast["currently"]["temperature"]
    conditions = forecast["currently"]["summary"]
    puts "it is currently #{current_temperature} and #{conditions}"

    # the next days forecast
    for day in forecast["daily"]["data"]
    puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}"
    end


    #News
    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d049d79760cb4b7aac606da81e683918"
    news = HTTParty.get(url).parsed_response.to_hash
    # news is now a Hash you can pretty print (pp) and parse for your output
    puts news
    

end


    
