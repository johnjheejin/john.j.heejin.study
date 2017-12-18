require 'forecast_io'
require 'awesome_print'
require 'pry'
require 'geocoder'

def f_to_c(f=0)
	((f - 32) * 5 / 9).round(1)
end

print '어디가 궁금하세요? : '

location = gets.chomp!

loCord = Geocoder.coordinates(location)

ForecastIO.configure do |configuration|
  configuration.api_key = 'c3c46f2ceb471e5d5bf6cd29b5708bfe'
end

forecast = ForecastIO.forecast(loCord[0], loCord[1])

f = forecast.currently

puts f.summary
puts f_to_c f.apparentTemperature