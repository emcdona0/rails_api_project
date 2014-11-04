require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def location


# puts "The current temperature at #{the_address} is #{the_temperature} degrees."
# puts "The outlook for the next hour is: #{the_hour_outlook}"
# puts "The outlook for the next day is: #{the_day_outlook}"

url_of_data_we_want = "https://maps.googleapis.com/maps/api/geocode/json?address="+params[:address]
raw_data = open(url_of_data_we_want).read
parsed_data = JSON.parse(raw_data)


# Let's store the latitude in a variable called 'the_latitude',
#   and the longitude in a variable called 'the_longitude'.

the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

url_of_data_we_want_2 = "https://api.forecast.io/forecast/21fc8454b0c2983829ad085802896e7e/"+the_latitude.to_s+","+the_longitude.to_s
raw_data_2 = open(url_of_data_we_want_2).read
parsed_data_2 = JSON.parse(raw_data_2)

@the_temperature = parsed_data_2["currently"]["temperature"]
@the_hour_outlook = parsed_data_2["hourly"]["data"][0]["summary"]
@the_day_outlook = parsed_data_2["daily"]["data"][0]["summary"]


    render "location"






  end
end
