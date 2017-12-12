require 'sinatra'

# 기본 페이지
get '/' do  
	"<a href='/random'>메뉴를 정해줄게요</a>"
end

get '/random' do  

	menus = ["햄버거","샌드위치","샐러드"]
	menu_url ={
		"햄버거" => "https://static.pexels.com/photos/70497/pexels-photo-70497.jpeg",
		"샌드위치" => "http://travel.home.sndimg.com/content/dam/images/travel/fullset/2014/07/20/32/food-paradise-102-ss-001.rend.hgtvcom.966.544.suffix/1491584380240.jpeg",
		"샐러드" => "https://www.heartfoundation.org.au/images/made/images/uploads/recipes/Lunch/Prawn_and_avocado_salad_High_res_800_480_85_s_c1.jpg"
	}

	@menu = menus.sample
	@url = menu_url[@menu]

	erb :random
end