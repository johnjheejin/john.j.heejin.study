# Day3

### git 환경 구성하기

작성하는 당시에는 'github desktop'을 사용하고 있지만, 그와 무관하게 vim환경으로 실습하기 위한 환경을 구성합니다. 교육제공 환경 최적화 목적으로(익숙함) git을 다룰 때 Unix tools를 cmd에서 활용하면서 vim을 통해 다룹니다.

#### 시작하기 전 간단한 리눅스 명령어

```
ls
```

현재 폴더의 데이터를 확인

```
cd 경로
```

경로로 directory를 변경

```
pwd
```

현재 작업경로를 표시

```
.
```

현재경로

```
..
```

상위경로



#### vim을 활용하여  git을 올려보자.

처음 github로 repository를 만들어 보자 그럼 	

##### …or create a new repository on the command line

```
echo "# gittest" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/johnjheejin/gittest.git
git push -u origin master
```

이처럼 친절하게 안내되어있다. 다만 이는 Unix환경을 이용해 설치된 git을 대상으로 명령어를 안내한 것이다. 금방 Unix환경을 활용해서 설치했기 때문에 

```
echo "# gittest" >> README.md
```

리눅스로 폴더에 파일만들기를 제외한 모든 명령어를 쓸 수 있다.



##### 실습을 위해 원하는 폴더를 만들고 연동할 파일을 올려보자.

``` 
cd gittest
```

gittest 로 위치한다

```
git init
```

```
실행결과:
Initialized empty Git repository in C:/gittest/.git/
```



그리고 저장할 데이터를 지정한다.

```
git add .
```



사용자 정보가 필요한 경우 이와 같이 유저정보를 추가한다

```
git config --global user.name "Init"
git config --global user.email "init@init.init"
```



그리고 갈 위치를 지정한다.

```
git remote add origin https://github.com/johnjheejin/gittest.git
```



master branch에 add된 파일들을 올린다

```
git push -u origin master
```

```
실행결과:
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 280 bytes | 280.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0)
To https://github.com/johnjheejin/gittest.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
(파일이 github repository에 잘 들어간 것을 확인할 수 있다)
```



### Ruby에서 객체가 아닌것은 

붉은 색으로 표시되는 것들

block # do ~ end 에서 ~에 해당되는 코드덩어리



### symbol

```ruby
:likethis
likethat:
```

위와같은 형태로 표현할 수 있다.

이는

```ruby
'likethis'
'likethat'
```

의 역할을 한다. 요즘 스타일이라고한다.



### sinatra

빠르게 웹페이지를 만들 수 있는 gem

##### sinatra.rb

```ruby
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
```

```
실행결과:
[2017-12-12 10:23:11] INFO  WEBrick 1.3.1
[2017-12-12 10:23:11] INFO  ruby 2.4.2 (2017-09-14) [x64-mingw32]
== Sinatra (v2.0.0) has taken the stage on 4567 for development with backup from WEBrick
[2017-12-12 10:23:12] INFO  WEBrick::HTTPServer#start: pid=7572 port=4567
::1 - - [12/Dec/2017:10:23:14 +0900] "GET /init HTTP/1.1" 200 33 0.0050
::1 - - [12/Dec/2017:10:23:14 대한민국 표준시] "GET /init HTTP/1.1" 200 33
```

```
localhost:4567/ 의 실행결과:
Hello there
```

```
localhost:4567/temp 의 실행결과:
오늘따라 날씨가 좋구만.
```

```
localhost:4567/welcome1/희진 의 실행결과:
희진이구나, 어서와
```

```
localhost:4567/welcome2/칭화 의 실행결과:
칭화, 오늘은 어떤 하루를 보내고 있니?
```

```
localhost:4567/cube/5 의 실행결과:
125
```



### sublimetext를 활용하여 html 빠르게 작성하기

.html파일을 만들면 emmet이 알아서 추가되는데,

````d
html
````

입력하고 tab을 누르면

```html
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

</body>
</html>
```

이것이 알아서 생긴다

emmet은 이렇게 tab을 활용해서 입력하는 것이기 때문에

img, h1 등을 입력하고 tab을 누르면 알아서 태그가 생성된다



### erb

루비언어가 들어간 파일을 뜻한다. 이 파일로 저장된 형태의 파일에서는 ruby로 기 작성된 코드를 활용할 수 있다.

```ruby
erb :이름
```

이렇게 만든 후에는

반드시 해당 경로의 /views 폴더안에 같은 선언된 symbol과 같은 이름의 erb파일이 있어야 한다.



### sinatra에서 html 파일 보여주기

##### sinatra_view.rb

```ruby
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
	@bye = "bye, seeya!" # @보내는변수 = "문구, 문구!"
	# ruby를 이용하여 작성된 문구.
	erb :outro
	# outro.erb가 views안에 있어야하며,
  	# 코드에서 선언 된 것들을 erb파일에서 활용할 수 있다.
end
```

##### intro.html

```html
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<h1>intro!</h1>
</body>
</html>
```

##### views/ outro.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<h1>outro.</h1>
	<!-- @bye는 sinatra_view.rb에서 가져온 데이터 -->
	<h2><%= @bye %></h2>
</body>
</html>
```

```
localhost:4567/intro 의 실행결과:
intro! (h1 태그)
```

```
localhost:4567/outro 의 실행결과:
outro (h1 태그)
bye, seeya! (h2 태그)
```



### 출력을 할 변수에는 @을 붙어야한다



### hash

python의 dictionary의 정의가 제일 맞다고 본다. 보통 인덱스가 정해진 데이터들을 잘 쓰며, 단순한 배열보다 이것을 더 자주보고 쓸 것이다.

hash rocket은 => 이 로켓모양을 뜻하며 key가 가르키는 값을 보여준다.

```ruby
	hash ={
		"key" => "arrtibute",
		"key2" => "arrtibute2"
	}
```

단순히 배열인 경우 각 키에 대한 속성을 정의하기 어려운데, hash는 이를 쉽게 처리할 수 있도록 해준다.

##### sinatra_hash_view_a.rb

```ruby
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
```

##### random.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<h1><%= @menu %></h1>
<img src="<%= @url %>" width="400" height="300">
<a href="/random">다시 골라주세요</a>
<a href="/">홈으로 돌아가기</a>
</body>
</html>
```

```
localhost:4567/ 의 실행결과:
메뉴를 정해줄게요 (텍스트를 누를 수 있으며 누르면 ./random 으로 이동한다.)
```

```
localhost:4567/random 의 실행결과:
(정해진menu 이름)
(이름에 매칭된 이미지)
다시 골라주세요(./random 으로 이동한다.)
홈으로 돌아기기(./ 으로 이동한다.)
```

