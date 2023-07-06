require "open-uri"
require "json"
require "http"

puts "Where are you?"
user_location = gets.chomp
puts "Checking the weather in " + user_location + "......."


gmaps_key = ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

raw_gmaps_data = URI.open(gmaps_url).read

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

first_result_hash = results_array.at(0)

geometry_hash = first_result_hash.fetch("geometry")

location_hash = geometry_hash.fetch("location")

latitude = location_hash.fetch("lat")

longitude = location_hash.fetch("lng")

puts "Your coordinates are " + latitude.to_s + ", " + longitude.to_s

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

raw_pirate_weather_data = URI.open(pirate_weather_url).read

parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)

currently_array = parsed_pirate_weather_data.fetch("currently")

temperature  = currently_array.fetch("temperature")

puts "It is currently " + temperature.to_s + "\u00B0" +"F."

time = Time.new

epoch_rep = time.strftime("%s")

pp epoch_rep

pp Time.at(epoch_rep.to_f)
