require 'stock_quote'
#누군가가 만들어 둔 gem을 가져다가 쓰겠다.

stock = StockQuote::Stock.quote('aapl')
#이 한줄로 aapl, 애플사에 대한 것을 모든 정보를 다 가져오는거다.
puts stock.name
puts stock.l