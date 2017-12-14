# Day5

- day4의 vagrant 환경구성은 차후에 진행합니다. (그만큼 일정이 dynamic한 요즘)




### form

뭔가를 입력받을 때 엄청 자주 씁니다

form action

##### get.rb

```ruby
require 'sinatra'

get '/' do
	erb :index
end
```

##### index.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<h1>뭐든지 검색해요.</h1>
	<form action="https://search.naver.com/search.naver">
		<!-- input name은 key값 value는 적용값 -->
		naver<hr>
		검색어 <input type="text" name="query"> <!-- 검색내용보내는 녀석 -->
		<input type="submit" value="검색">
	</form>
	<p></p>
	<form action="https://www.google.co.kr/search">
		google<hr>
		검색어 <input type="text" name="q">
		region <input type="text" name="gl" width="3">
		<input type="submit" value="검색">
	</form>
</body>
</html>
```

```
실행결과:
(index.erb의 내용이 보여진다.)
뭐든지 검색해요 (h1태그)
naver (입력폼) (검색버튼)
google (입력폼1) (입력폼2) (검색버튼)
```



### before

```ruby
before do
	p '-------------------------'
	p params
	p '-------------------------'
end
```

do 가 실행되기전에 이거해주세요~ 라고 하는 것이다.

#### fake_opgg

몇몇 비슷한 기능화면을 작성하는 것으로 파일 저장 및 로깅, html을 연습합니다.

##### app.rb

```ruby
require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'csv'

get '/' do
	erb :index
end

get '/search' do
	@p_userName = params[:userName]
	@encoded_userName = URI.encode(@p_userName)
	
	response = HTTParty.get("http://www.op.gg/summoner/userName=" + @encoded_userName)
	html = Nokogiri::HTML(response.body)

	@win = html.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins')
	@lose = html.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses')
	@tier = html.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierRank > span')

	File.open("log.txt","a+") do |file| # a+표시는 여기서 추가해서 쓰겠다는 이미다.
		file.write("#{@p_userName}/#{@tier.text}/#{@win.text}/#{@lose.text}/"+Time.now.to_s+"\n")
		# txt 파일은 string형태로만 넣어야한다.
	end

	# 덩어리(배열) 처럼 묶어주는 CSV
	# << 표시로 배열에 값을 집어넣는다.
	CSV.open("log.csv","a+") do |csv| 
		csv << [@p_userName, @tier.text, @win.text, @lose.text, Time.now.to_s]
	end

	erb :search
end

before do
	p '-------------------------'
	p params
	p '-------------------------'
end
```



