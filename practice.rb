# EXERCISE
# Using the Ruby hash `weather_data` that includes weather forecast data for Chicago,
# write a weather summary out to the screen including the current conditions and upcoming forecast.
# Something like the output below.

# Sample output:
# In Chicago, IL it is currently 67 degrees and cloudy.
# The rest of today will be a high of 65 and scattered shows.
# The upcomming weather forecast is:
# Wednesday: a high of 65 and scattered showers.
# Thursday: a high of 67 and partly cloudy.
# Friday: a high of 59 and rain.
# Saturday: a high of 77 and cloudy.
# ...

# STEPS
# Look at the weather_data hash.
# Find the current data.
# Build a string with the text and dynamic data from the hash.
# "In #{...} it is currently #{...} degrees and #{...}"
# Find the array of forecast data.
# Read only the first element of that array to display the conditions for the rest of today.
# Use a loop to display the daily summary for the upcoming forecast.

# 1. inspect the weather_data hash
# puts weather_data

# CHALLENGE
# Can you display the weather forecast summary for a user-entered city?
# Use the following code at the very top of the file and then replace "chicago" in the api url with the user-entered city:
# puts "What city are you in?"
# city = gets.chomp
# puts city
# Note: what happens if the user-entered value is not a known city? You'll want to do some error handling.

puts "Check the weather in which city?"
city = gets.chomp
#The code will look for an empty space in the city string.  
#If it finds 1 or more spaces, it will replace it/them with nothing, effectively just removing those spaces.
city = city.gsub(" ", "")

# even though it says don't change this, code - replace "chicago" in the url with #{city}:

# DON'T CHANGE THIS CODE
# ----------------------
require "net/http"
require "json"
url = "https://weatherdbi.herokuapp.com/data/weather/#{city}"
uri = URI(url)
response = Net::HTTP.get(uri)
weather_data = JSON.parse(response)
# ----------------------

# ... code comments

# 1. inspect the weather_data hash
# puts weather_data

# 2. check if user submits an unknown city and handle edge case
if weather_data["status"] == "fail"

  # 3. display error message to the user
  puts "we don't know that city.  try again."

# 4. otherwise, display weather summary for city
else

  # 5. get the current temp and conditions
  current_temp = weather_data["currentConditions"]["temp"]["f"]
  current_condition = weather_data["currentConditions"]["comment"]

  # 6. display string with region, current temp and conditions
  puts "In #{weather_data["region"]} it is currently #{current_temp} and #{current_condition}."

  # 7. get the summary forecast for today
  today_forecast = weather_data["next_days"][0]
  
  # 8. display string with summary forecast data
  puts "The rest of today will be a high of #{today_forecast["max_temp"]["f"]} and #{today_forecast["comment"]}."

  # 9. loop through array of daily forecast data
  puts "The upcoming weather forecast is:"
  for daily_forecast_data in weather_data["next_days"]
  
    # 10. get the day of week, high temp and conditions for each day's forecast data
    day_of_week = daily_forecast_data["day"]
    high_temp = daily_forecast_data["max_temp"]["f"]
    conditions = daily_forecast_data["comment"]
    
    # 11. display string with day of week and day's forecast summary
    puts "#{day_of_week}: a high of #{high_temp} and #{conditions}."

  # 12. end loop
  end

# 13. end conditional
end