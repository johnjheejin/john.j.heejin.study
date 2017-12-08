require 'launchy' #실행을 위해

coins = ['BTC','ETH','BCH']
# coins라는 배열.
# , 으로 구분하며 각각 요쇼를 coins[0], coins[1], coins[2] 로 칭할 수 있다.

naverurl = 'https://search.naver.com/search.naver?where=nexearch&query='
#검색을 시도해보고 알 수 있는 주소.

Launchy.open(naverurl + coins[1]) 
# 실행 시 대문자를 꼭 확인해야 한다.
# coins[1] 은 'ETH'를 가르킨다.

coins.each do |coin|
# coins 라는 배열을 가진 객체를 
# .each 각각 
# do 실행하는데 
# |coin| 각 하나의 녀석을 coin으로 부른다.
	keyword = naverurl + coin
	Launchy.open(naverurl + coin)
end