require 'sinatra'

# '/'은 기본 페이지를 뜻하며,
# 서버주소 뒤에 '/' 또는 '/temp'등을 입력 받았을 때 행동을 한다.
get '/' do  
	"Hello there"
end

get '/temp' do
	"오늘따라 날씨가 좋구만."
end

# 파라미터 사용해보기
# :parameter
get '/welcome1/:name' do 
	# params 사용해보기 1
	name = params['name']
	"#{name}이구나, 어서와."
end
get '/welcome2/:name' do 
	# params 사용해보기 2
	"#{params['name']}, 오늘은 어떤 하루를 보내고 있니?"
end

# 숫자 다루기
get '/cube/:int' do
	int = params[:int].to_i # :int 는 'int' 와 같이 쓸 수 있다
	
	#int = int*int*int
	intCube = int ** 3
	"#{intCube}"
end