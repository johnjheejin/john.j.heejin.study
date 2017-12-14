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
