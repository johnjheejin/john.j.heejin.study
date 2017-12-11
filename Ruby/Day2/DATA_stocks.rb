# stocks 조회하기 
# DATA 사용해보기
require 'stock_quote'

DATA.each do |company|
	company.chomp! #뒤에 \n을 짤라버리는 명령어
	company = StockQuote::Stock.quote(company)
	puts "#{company.name} 의 가격은 $ #{company.l} 입니당."
end

__END__
aapl
tsla
msft
fb
googl