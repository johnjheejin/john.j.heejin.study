# Day4

### codecademy

HTML5를 배우기 좋은 사이트. 딱히 유료라고해서 좋은지 모르겠더라 (교육자 주) 가입하고 시작하기만 누르면 바로 시작할 수 있다.

https://www.codecademy.com/

HTML5의 교육은 직집 눌러보면서 배우는 것 만큼 빠른 방법이 없다.



### Rails의 모토

##### DRY

Don't Repeat Yourself 반복해서 뭔가를 입력하는건 나쁜거야

##### COC

Convention Over Configration 규칙을 지키면 편해진다

##### 프로젝트 단위

프로젝트 단위로 움직일 때 폴더를 쓴다.



### 리눅스 명령어

- ##### cd


```
cd folder1/folder2
```

```
실행결과
$ ~/folder1/folder2
```

```
cd ~
```

- ##### ls


```
ls -al
```

```
실행결과:
$ ls -al
total 1
drwxr-xr-x 1 Heejin 197609   0 12월 13 09:39 ./
drwxr-xr-x 1 Heejin 197609   0 12월 13 09:39 ../
-rw-r--r-- 1 Heejin 197609 237 12월 13 09:52 movie.rb
drwxr-xr-x 1 Heejin 197609   0 12월 13 09:38 views/
```

현재 디렉토리에 숨김없는 모든 자료를 보여준다. (권한까지)

- ##### mkdir


```
mkdir folder
```

```
실행결과:
(새로운 folder라는 폴더가 만들어진다)
```

- ##### rm


```
rm -rf folder/
```

folder안의 모든 것이 삭제된다.

- ##### touch


```
touch file.hello
```

```
실행결과:
(touch file.hello 라는 파일이 만들어진다)
```

touch 명령어를 쓰면 확장자 상관없이 파일만들기에 유용하다.

- ##### 단축키 Ctrl + l 


```
실행결과:
(리눅스 cmd를 청소한다)
```





### 영화 추천해주기 : crawling, sinatra 복습

##### movie.rb

```ruby
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
```

##### index.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<h1>영화추천</h1>
<img src="https://jacesky1.files.wordpress.com/2016/02/watcha-play_image-1.png" width="800" height="480">
<a href="/randomMovie">추천</a>
</body>
</html>
```

##### randomMovie.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<img src="http://cfile7.uf.tistory.com/image/2407C83457DBCD061F5771" width="200" height="140">
<a href="<%= @url%>">자료출처 : 네이버 영화 상영작 및 예정작</a>
<hr>
<a href="/randomMovie">다시 골라주기</a>
<a href="/">메인페이지로 돌아가기</a>
<p><%= @movie%></p>
</body>
</html>
```

```
localhost:4567/ 의 실행결과:
영화 추천 (h1 태그)
(왓챠의 영화추천화면.. 추천하게 생긴 그림이 보인다)
추천 (링크를 누르면 /randomMovie로 이동한다)
```

```
localhost:4567/randomMovie 의 실행결과:
(네이버 영화 상영작 및 예정작 사이트가 열려있는 사진)
자료출처 : 네이버 영화 상영작 및 예정작 (링크를 누르면 네이버 영화 상영작 및 예정작 사이트로 이동)
다시 골라주기 (링크를 누르면 /randomMovie  로 이동하다)
메인페이지로 돌아가기 (링크를 누르면 / 로 돌아간다)
```



### uri= urn + url 이다

- URI (Uniform Resource Identifier)

```
https://data.html#posts
```

- URN (Uniform Resource Name)

```
data.html#posts 
```

- URL (Uniform Resource Locator)

```
https://data.html
```



### p / puts 차이

```ruby
puts '1'
```

```
실행결과:
1
```

```ruby
p '1'
```

```
실행결과:
"1"
```

텍스트인 경우 "" 로 표시해준다.



### 가상환경 설치

리눅스 안의 파일을 windows에 유연하게 다루기 위해서 하던 실습을 중단하고 가벼운 가상 os를 설치해서 쓰기 위해 VirtualBox 및 vagrant_1.9.5를 설치한다.

#### virtualBox 설치

http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html

링크를 따라가서 그냥.. 설치한다.

#### vagrant 설치

cmd를 활용해 실행한다.

```
vagrant init
```

```
실행결과:
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
(폴더안에 Vagrantfile이 생긴다)
```

이후 생산된 Vagrantfile을 실습환경을 위해  다음과 같이 수정한다.

```ruby
수정하는 부분:
...
config.vm.box = "ubuntu/xenial64"
...
config.vm.network "forwarded_port", guest: 3000, host: 3000
...
```

vagrant 가상환경을 설치한다.

```
vagrant up
```

```
실행결과:
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'ubuntu/xenial64' could not be found. Attempting to find and install.
...
    default: VirtualBox Version: 5.1
==> default: Mounting shared folders...
...
(이후 vagrant가 설치된 파일 안에 .vagrant폴더 안으로 가상머신이 설치된다.)
```

vagrant를 실행한다.

```
vagrant ssh
```

```
실행결과:
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-103-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.
```

그럼 다음과 같은 화면을 볼 수 있다.

```
ubuntu@ubuntu-xenial:~$
```



```
lsb_release -a
```

```
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.3 LTS
Release:        16.04
Codename:       xenial
```



#### rails 설치

버전이 16.04 버전으로 확인되었으므로 해당하는 rails를 설치한다. https://gorails.com/setup/ubuntu/16.04 해당 페이지가 순서가 잘 나와있으므로 이를 따라간다.

```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn
```

복사 붙여넣기하는 방법은 Shift + Insert 키를 누르는 것이다.

```
...
After this operation, 292 MB of additional disk space will be used.
Do you want to continue? [Y/n]
```

```
y
```

이후 설치가 완료된다.



```
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
```

```
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
```

```
rbenv install 2.4.2
```

여기까지 설치가 완료된다.



시스템 전반에서 루비를 활용하기 위해 global설정을 한다.

```
rbenv global 2.4.2
```

이후 버전을 ruby 명령어를 통해 확인할 수 있다.

```
ruby -v
```

```
실행결과:
ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]
```



rbenv : ruby invironment



### 실전 : 아마존 데이터를 엑셀로 넣는 노가다를 자동화 해보자 는 나중에



```ruby
# 검색하는 시퀀스
# 1 아마존에 접속한다
# 2 검색어를 입력한다
# 3 가격을 본다
# 4 엑셀에 입력한다

require 'mechanize'
```



