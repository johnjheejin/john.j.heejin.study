require 'sinatra'

# 기본 페이지
get '/' do  
	"<h1>기본페이지 입니다.</h1>"
end

get '/intro' do  
	send_file "intro.html"
	# root 폴더위에 있는 파일이며,
	# view 선언시 보내 표시하도록 할 수 있다.
end

get '/outro' do  
	@bye = "bye, seeya!"
	# ruby를 이용하여 작성된 문구.
	erb :outro
	# outro.erb가 views안에 있어야하며,
  	# 코드에서 선언 된 것들을 erb파일에서 활용할 수 있다.
end