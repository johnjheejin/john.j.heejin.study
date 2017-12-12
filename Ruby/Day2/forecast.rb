require 'geocoder'
require 'forecast_io'

print '어디가 궁금하세요? : '

location = gets.chomp!
#get함수가 들어가 있으면 우선 멈추고 입력을 받는다.
loCord = Geocoder.coordinates(location)

ForecastIO.configure do |configuration|
  configuration.api_key = 'c3c46f2ceb471e5d5bf6cd29b5708bfe'
end

forecastInfo = ForecastIO.forecast(loCord[0], loCord[1])


forecast = forecastInfo.currently

puts forecast.summary
puts forecast.apparentTemperature