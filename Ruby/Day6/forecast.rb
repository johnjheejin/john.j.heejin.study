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

# ap forecast 해당 주석을 풀면 해당 gem이 가져오는 결괄르 조금 이쁘게 볼 수 있다.

# binding.pry 주석을 풀면 해당 라인까지 실행되고 
# 선언된 변수나 정의된 함수를 이용해서 interactive 환경을 만들 수 있다.