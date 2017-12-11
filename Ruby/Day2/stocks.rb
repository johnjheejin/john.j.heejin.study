# stocks 조회하기 appl, tsal, msft
require 'stock_quote'

companies = ['aapl','tsla','msft']

companies.each do |company|
	company = StockQuote::Stock.quote(company)
	# puts company.name
	# puts company.l
	puts "#{company.name} 의 가격은 $ #{company.l} 입니당."
end
