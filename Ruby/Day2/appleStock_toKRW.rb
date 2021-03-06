require 'stock_quote'
require 'eu_central_bank'

def dollarExchange(to, amount)
	# amount = amount.to_i #string이래 그래서 변환.
	amount = amount.to_i if amount.is_a? String
	bank = EuCentralBank.new
	bank.update_rates

	amount * bank.exchange(100, 'USD', to)
end

	stock = StockQuote::Stock.quote('aapl')

puts "#{stock.name}은 #{stock.l} / 원달러 환율은 #{dollarExchange 'KRW', 1} 이며"

aapl_stock = stock.l.to_i
dollar_toKRW = dollarExchange 'KRW', 1

puts "한국돈으로 #{appl_stock * dollar_toKRW} 입니다."
