## Day2

### 경로 및 파일 생성하기 : 복습

Day01에서 했던 실습을 다시해본다.

#### txts.rb

```ruby
# txts, file-again
# 폴더는 txts
# 파일 제목은 1.txt 2.txt
# 파일내용에 '좋은 아침입니다!'
Dir.chdir ("txts") 
2.times do |n|
	# do 를 한건데 여기서만 쓰일 기본변수를 n를 지칭한다.
	# 여기서 기본변수는 쉽게 변경할 수 있다.
	n+=1
	File.open(n.to_s + ".txt", "w") do |file|
		file.write("좋은 아침입니다!")
	end
end
```

```
실행결과:
(txts라는 폴더가 생긴다)
(txts폴더안에 1.txt 2.txt가 생긴다)
(각 파일이 생성될 때 마다 "좋은 아침입니다!"가 작성되어 저장된다.)
```



### 파일이름 변경하기

#### rename.rb

```ruby
Dir.chdir("txts")
# 작업경로를 txts로 변경한다.
files = Dir.entries(Dir.pwd).reject {|name| name[0] == '.'}
# 현재 폴더에서 .으로 시작하는 애들을 제외하고 엔트리에 올린다.
# 이걸 하는 이유는 dir들을 제외한 것들에게만 수정을 가하기 위해서다.
# (.)PWD (..)UP DIRECTORY
files.each do |file|
	File.rename(file, "hello" + file)
	# rename(변경 전 이름, 변경 후 이름.)
end
```

```
실행결과:
(txts폴더안의 파일들이 hello가 붙은 체로 수정된다.)
```





### 나스닥 코드를 단간하게 몇줄로 긁어올 수 있다면?

Day01에서는 간단히 사용자가 접하는 웹페이지가 제공하는 걸 가져왔다.  이번에는 누군가가 주식정보만 간단하게 제공하는 것을 만들어 둔 것을 가져와보자.

https://github.com/tyrauber/stock_quote 문서를 참고하고 gem install stock_quote 로 설치후 실행한다.

#### appl_stock.rb

```ruby
require 'stock_quote'
#누군가가 만들어 둔 gem을 가져다가 쓰겠다.

stock = StockQuote::Stock.quote('aapl')
#이 한줄로 aapl, 애플사에 대한 것을 모든 정보를 다 가져오는거다.
puts stock.name
puts stock.l
```

```
실행결과:
Apple Inc.
169.37
```



Day01에서 학습한 배열 반복문을 이용해서  여러 회사의 정보를 가져올 수 있다.

#### stocks.rb

```ruby
# stocks 조회하기 appl, tsal, msft
require 'stock_quote'

companies = ['aapl','tsla','msft']

companies.each do |company|
	company = StockQuote::Stock.quote(company)
	# puts company.name
	# puts company.l
	puts "#{company.name} 의 가격은 $ #{company.l} 입니당."
end
```

```
Apple Inc. 의 가격은 $ 169.37 입니당.
Tesla Inc 의 가격은 $ 315.13 입니당.
Microsoft Corporation 의 가격은 $ 84.16 입니당.
```



### DATA의 사용

계속해서 쌓이는 정보를 이용할 때  배열을 늘릴 수도 있겠지만, 훨씬 간단한 방법인 DATA를 활용하는 방법을 소개한다. 이때 DATA를 작성하면서 ENTER에 해당하는 \n도 같이 기록되닌 이는 chomp!로 자른다.

#### DATA_stocks.rb

```ruby
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
```

```
Apple Inc. 의 가격은 $ 169.37 입니당.
Tesla Inc 의 가격은 $ 315.13 입니당.
Microsoft Corporation 의 가격은 $ 84.16 입니당.
Facebook Inc 의 가격은 $ 179.00 입니당.
Alphabet Inc 의 가격은 $ 1,049.38 입니당.
```



### 환율정보를 가져와보자

#### currency.rb

```ruby
require 'eu_central_bank' #다른 환율 gem도 많지만, 제일 굳건해 보이는 이름.
 
bank = EuCentralBank.new # 은행 객체생성

from = 'USD'
to = 'KRW'

bank.update_rates # 은행 객체에 환율정보를 업뎃해줘

result = bank.exchange(100, from , to)
# 100 cent = 1 dollar 를 from에서 to로

puts "#{from} 1 => #{to} #{result}"
```

```
실행결과:
USD 1 => KRW 1095
```





### Bundler : 문명의 이기

지금까지 require 'gemname' 형태로 불러오는데, 이를 위해서 gem을 하나하나 설치해줘야 했다. 이를 해결하기 위한 수단인 bundler를 설치해 활용해보자. 다만 이 bundler또한 Gem이기 때문에 이를 설치해야한다.

사용할 Gem을 Gemfile에 작성한다. 이후 타 시스템에서 불러올 때 bundle 명렁어를 1번 실행한다.

#### Gemfile

```ruby
source 'https://rubygems.org'

#브라우저 실행
gem 'launchy'

#주식정보
gem 'stock_quote'

#환율정보
gem 'eu_central_bank'

#http parser
gem 'httparty'

#crawler
gem 'nokogiri'
```

