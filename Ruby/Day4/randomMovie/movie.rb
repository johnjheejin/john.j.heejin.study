require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do # 컨트롤러구간
	erb :index # 뷰
end

get '/randomMovie' do
	# erb와 유관한 데이터 쓸거니까 @명시
	@url = 'http://movie.naver.com/movie/running/current.nhn' 
	# 데이터를 가져올 @url을 적어줍니다.

	# @page = Nokogiri::HTML(open(@url),nil,'UTF-8') 
	@page = Nokogiri::HTML(open(@url)) 
	# 안에서 @url을 열어줘야대요 
	# 중간옵션은 없다는 말이고
	# 뒤에 인코딩 세트는 UTF-8이다.
	@movie_title = Array.new
	# @movie_title이라는 배열을 새로 만들거야

	@page.css("ul.lst_detail_t1 dt a").each do |titleData|
		# page안에 있는 ul태그를 가진 애인데 클래스가 lst_detail.t1인 걸 가져와줘
		# 그 다음에 dt태그 안에 a태그 안에 있는걸 가져와줘
		# 저기서 a 가 제목이더라
		# 그 문서안에 그거마다 반복할거야
		# 그 때 데이터를 titleData이라고해 
			@movie_title << titleData.text
			# titleData에서 text라고 되어있는 녀석을 @movie_title에 넣어줘
		end

	@movie = @movie_title.sample
	# @movie_title에 모인 배열중에서 샘플을 골라줘

	# p @movie_title
	puts @movie_title
	# 서버에 찍히는 글자들을 확인해보자.

	erb :randomMovie
end