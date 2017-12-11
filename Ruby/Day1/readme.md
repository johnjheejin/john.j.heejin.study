# Day1

### ' 이랑 "

```ruby
puts "hello1"
puts 'hello2'
```

```
실행결과:
hello1
hello2
```

이렇게만 보면 사용에 있어 ' 와 " 의 차이는 없어 보인다. 

하지만 ' 표현은 내부가 string이라고 정해주는 것이고, " 의 표현은 위처럼 한정된 것이 아니다.

##### apostrophe.rb

```ruby
# apostrophe 에제.
# #{hello} 사용해보기
hello = '안녕~'
puts 'How can I say "Hello~" in Korean?'
puts 'A: You can say #{hello}.'
puts "B: You can say #{hello}."
```

```
실행결과:
A: You can say #{hello}.
B: You can say 인사.
```

그렇기에 이러한 결과를 볼 수 있다.



### 비복원 추출 .sample

##### sample.rb

```ruby
# sample 예제.
# 1..45, 1부터 45까지 배열을 만들어라
Balls = [*1..45]
# 객체의 샘플을 출력한다를 6번 실행한 것을 출력하라.
print Balls.sample 6 
```

```
실행결과:
[2, 16, 43, 38, 29, 39]
```

.sample은 비복원 추출이다.



### fizzbuzz 게임

한국에서의 369와 같은 게임. 369가 박수를 친다면, 이 게임은 3의 배수에 fizz 5의 배수에 buzz라고 말하면 된다. 15의 배수(3과 5의 공배수)라면 fizzbuzz라고 말한다.

```ruby
# 문제
# 숫자를 세서 올라가는데,
# 3의 배수는 fizz
# 5의 배수는 buzz
# 15의 배수는 fizz buzz가 되어야한다.
```

이렇게 문제를 준다면 흔히 할 수 있는 실수가 있다. 우선 도전해보자.

##### 재료

```ruby
# for : 1에서 15까지 1씩 증가하는 수를 i로 정의하며 반복한다.
for i in 1..15
end
```

```ruby
# if : 만약 ㅁ 라면 그게아니고 ㄴ 라면 2 그것도 아니면 3을 한다.
if ㅁ
  1
elsif ㄴ
  2
else ㅇ
  3
end
# 2개 이상의 조건은 && 와 || 로 나타내며 각각 AND 와 OR의 조건을 뜻한다.
if A && B
end
if C || D
end
```

```ruby
# 연산자 : 결과는 ture 또는 false 로 표현한다.
a == b
a != b
a % b
# 사친연산 및 대소관계는 생략.
```



##### fizzbuzz.rb

```ruby
# 문제
#1 숫자를 세서 올라가는데,
#2 3의 배수는 fizz
#3 5의 배수는 buzz
#4 15의 배수는 fizz buzz가 되어야한다.

message = "fizzbuzz game"
puts message

# 풀이
#0 머릿속으로 숫자를 생각한다,
#4 15의 배수는 fizz buzz가 되어야한다.
#2 3의 배수는 fizz
#3 5의 배수는 buzz
#1 숫자를 세서 올라가는데,

for i in 1..15
	# i라는 변수가 1에서 15까지 증가한다.
    if i%3 == 0 && i%5 == 0
        puts "fizzbuzz"

        elsif i%3 == 0
            puts "fizz"
        elsif(i%5 == 0)
            puts "buzz"
        else
        	puts i
    end
end
```

```
실행결과:
fizzbuzz game
1
2
fizz
4
buzz
fizz
7
8
fizz
buzz
11
fizz
13
14
fizzbuzz
```





### 쿼리를 활용해 검색을해보자

네이버에서 아무것이나 검색을 하고나면 주소창에 주소가 남는다. 이를 가져와서 간단하게 검색을 하는 프로그램을 만들어본다. 이때 실행하기위해 Launchy 라는 gem이 쓰인다.

##### 1browser.rb

```ruby
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
```

```
실행결과:
(네이버에서 ETH를 검색한 결과를 보여준다)
(네이버에서 BTC를 검색한 결과를 보여준다)
(네이버에서 ETH를 검색한 결과를 보여준다)
(네이버에서 BCH를 검색한 결과를 보여준다)
```



### ETH 시세확인

사이트에 접속하면 매번 시세정보가 나오는데 그 중 내가 원하는 텍스트만 간단한 결과로 출력할 수 있다. 이때 http 자료를 긁기위해 그리고 그 자료를 분석하기위해 httparty와 nokogiri가 쓰였다.

##### 2coin.rb

```ruby
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
```

```
실행결과:
556,300
```

(비트코인을 긁으면 배파아서)



### 폴더안에 파일을 만들어 보고 내용을 작성해보자

##### 3file.rb

```ruby
Dir.chdir("files") # files 라는 폴더로 파일 경로를 변경한다.

3.times do |n| 
# 3번 실행하는데 이 전체 구문에서 n이라는 변수가 있다.
	n += 1 
	# n은 이후 1이 더해진 값이 된다.
	File.open(n.to_s + ".txt","w") do |file| 
	# n녀석의 글자를 딴것과 .txt 를 합쳐 파일을 저장하면서 연다. 그러면서 취할 행동이 있으며, 이때 이를 file이라 부른다.
		file.write(n.to_s + "번째 txt") 
		# file안에 n녀석의 글자를 딴것과 번째 txt를 합친것을 작성한다.
	end
end
```

```
실행결과:
(files라는 폴더가 생긴다)
(files폴더 안에 1.txt부터 3.txt까지 파일이 생성된다)
(각 파일이 생성될 때 마다 내부에 *번째 txt 라는 내용이 적혀서 저장된다)
```

