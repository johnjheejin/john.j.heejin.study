require 'httparty' #http의 자료를 가져오기위해
require 'nokogiri' #긁어온 자료에서 값을 찾아주는 녀석

url = "https://coinpang.com/"
# 해당 사이트에서 간단하게 정보를 가져올 수 있다.
# 코인원은 그리지 못하도록 막혀있었다. 거래량에 따라 서버가 터지는 경우가 있기 때문.
response = HTTParty.get(url)
# 주소를 통해 가져온 데이터를 response에 담는다.
text = Nokogiri::HTML(response.body)
# 내용들중 HTML파일안의 body태크만 가져온다.
bithumb_eth =  text.css('#bithumb_eth')
# bithumb_eth 에 #bithumb_eth id로 등록된 부분을 텍스트를 긁어 담을 것이다.

puts bithumb_eth.text
# bithumb_eth객체의 text로 출력되는 부분을 출력한다.