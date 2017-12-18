require 'forecast_io'
require 'awesome_print'
require 'pry'

def f_to_c(f=0)
	((f - 32) * 5 / 9).round(1)
end


ForecastIO.configure do |configuration|
	configuration.api_key = 'c3c46f2ceb471e5d5bf6cd29b5708bfe'
end

forecast = ForecastIO.forecast(37.501520, 127.039595)
c = forecast.currently

puts "현재 날씨는 #{c.summary} 이고, \n섭씨 #{f_to_c(c.apparentTemperature)}입니다."

# ap forecast

# binding.pry