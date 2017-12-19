require 'httparty'
require 'nokogiri'
require 'uri'

class HomeController < ApplicationController
  # 
  def index

  end
  # 
  def welcome
  	@user = params[:user]
  	# user라는 이름으로 넘어온 parameter를 @user로 정의한다.
  end
  #
  def lunch_menu
  	@menus = ["짜장면","시레기","삼각김밥","점심뷔페"]
  end
  #
  def lol_info
  	@summoner = params[:summoner]
  	encoded_summoner = URI.encode(@summoner)
  	response = HTTParty.get("http://www.op.gg/summoner/userName="+encoded_summoner)
  	result = Nokogiri::HTML(response.body)

  	@win = result.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins')
  	@lose = result.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses')
  	@tier = result.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierRank > span')
  end
end
