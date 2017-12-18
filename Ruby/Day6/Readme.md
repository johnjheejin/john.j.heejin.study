# Day6

### Code Academy (~)

오늘 오전은 기상악화로 많은 인원이 결석한바, Code Academy로 개념을 일부 학습합니다. 기억해야겠다 싶은 것을 기록합니다.



##### print 와 puts의 차이

```ruby
print "hello!"
puts "Hello@"
```

```
실행결과:
hello!Hello@
```

##### .length

```ruby
puts "I love espresso".length
```

```
15
```

##### .reverse

```ruby
puts "hello".reverse
```

```
실행결과:
olleh
```

##### .upcase .downcase

```ruby
puts "heLLo".upcase
puts "Ruby".downcase
```

```
실행결과:
HELLO
ruby
```

##### =begin =end : 장문의 주석을 다는 방법

```ruby
=begin
hi
=end
```

##### Naming Conventions

따로 제한은 없지만, **자주 쓰는 것을 따르는 것**이 모두에게 마음이 편하다.

##### string interpolation

"" 문구사이에 원하는 변수를 넣는 것을 string interpolation이라 부른다.

```ruby
city = 'Seoul'
country = "KR"

print "#{city},#{country}"
```

```
실행결과:
Seoul,KR
```

##### .capitalize

```ruby
print 'Seoul city MY bro.'.capitalize
```

```
실행결과:
Seoul city my bro.
```

##### string methods

예시로 제시되는 두 줄은 같은 명령이다. 이를 string method라고 부른다.

```ruby
answer = answer.capitalize 
answer.capitalize!
```



### Vagrant 환경 구성 및 날씨 확인하는 프로그램 완성하기



##### 가상머신 끄기 halt

```
vagrant halt
```

Vagrant설치된 경로에서 Vagrantfile을 찾아서 연다. 이후 SINATRA 활용을 위해 4567포트를 하나 추가한다.



##### Vagrantfile

```
...
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 4567, host: 4567
...
```



##### vagrant up을 해서 VM을 구성한다.

```
vagrant up
```

```
실행결과:
Heejin@Galaxy MINGW64 ~/2017년/4차산업/LIKELION/vagrant
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'ubuntu/xenial64' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 3000 (guest) => 3000 (host) (adapter 1)
    default: 4567 (guest) => 4567 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
```

결과에서 보면 알 수 있듯이 3000 포트와 함께 4567 포트도 개방한다.



##### varant내부의 ubuntu 에 접속한다

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

12 packages can be updated.
10 updates are security updates.


Last login: Wed Dec 13 04:08:39 2017 from 10.0.2.2
```



### rbenv 로 VM 내부에 2.3.5 설치

```
rbenv install 2.3.5
```

```
실행결과:
Downloading ruby-2.3.5.tar.bz2...
```

##### 하는 이유는?

Ruby 개발 시 더 호환성을 위해 낮은 버전으로 써야 구동해야하는 경우에  바꿔서 실행할 수 있기 때문이다. 특히 rbenv는 이러한 버전관리를 종합적으로 해주는 역할을 하기에, 더욱 선호한다.



### 보다 효율적인 개발을 위해

#### Interactive Ruby를 잘 쓰자

하나하나 정의할때 마다 되는지 안되는지 짧은 분기별로 알 수 있다.

#### binding.pry : pry 활용하기

프로그램을 해당 선언 순간에 멈춘 상태에서 interactive Ruby처럼 활용할 수 있다. 즉 다양한 변수를 찾아갈 수 있고, 정의된 함수에 변수를 넣어 실행해볼 수 있다. 나올 때는 Ctrl +d를 누르면 빠져나온다 이후, 나머지 코드들이 실행된다. rails에 debugger가 있지만, 보다 활용도가 높아서 이것을 선호한다. 실제 코딩시에는 코딩 중간에 변수를 선언해보고 해당 바인딩에서 변수나 함수가 잘 동작하는지 확인한다.

#### Awesome print : 이쁘게 출력하기



##### forecast.rb

```ruby
require 'forecast_io'
require 'awesome_print'
require 'pry'

def f_to_c(f=0)
	((f - 32) * 5 / 9).round(1)
end


ForecastIO.configure do |configuration|
	configuration.api_key = 'c3c46f2ceb471e5d5bf6cd29b5708bfe'
end

forecast = ForecastIO.forecast(37.501520, 127.039595)
c = forecast.currently

puts "현재 날씨는 #{c.summary} 이고, \n섭씨 #{f_to_c(c.apparentTemperature)}입니다."

# ap forecast

# binding.pry
```

```
실행결과:
현재 날씨는 Partly Cloudy 이고,
섭씨 3.8입니다.
```



##### geocoder_forecast.rb

```ruby
require 'forecast_io'
require 'awesome_print'
require 'pry'
require 'geocoder'

def f_to_c(f=0)
	((f - 32) * 5 / 9).round(1)
end

print '어디가 궁금하세요? : '

location = gets.chomp!

loCord = Geocoder.coordinates(location)

ForecastIO.configure do |configuration|
  configuration.api_key = 'c3c46f2ceb471e5d5bf6cd29b5708bfe'
end

forecast = ForecastIO.forecast(loCord[0], loCord[1])

f = forecast.currently

puts f.summary
puts f_to_c f.apparentTemperature
```



mechanize는 시키는거 하는 친구야

```ruby
require 'mechanize'
require 'pry'

agent = Mechanize.new
agent.user_agent_alias = 'Windows Chrome'

page = agent.get('https://amazon.com')

binding.pry
```





```erb
[2] pry(main)> page.form
```

```
=> #<Mechanize::Form
 {name "site-search"}
 {method "GET"}
 {action "/s/ref=nb_sb_noss/132-3257620-4268506"}
 {fields
  [text:0x2ac0567c84cc type: text name: field-keywords value: ]
  [selectlist:0x2ac0567e5cfc type:  name: url value: search-alias=aps]}
 {radiobuttons}
 {checkboxes}
 {file_uploads}
 {buttons [submit:0x2ac0567c8a44 type: submit name:  value: Go]}>
```

```
[5] pry(main)> page.form['field-keywords']
=> ""
```





##### scrapper.rb

```ruby
require 'mechanize'
require 'pry'
require 'csv' #comma seprated values

agent = Mechanize.new
agent.user_agent_alias = 'Windows Chrome'

page = agent.get('https://amazon.com')

# 요소검사를 통해 검색창을 찾아감

search_form = page.form

search_form['field-keywords'] = 'Easystore 8tb'

# 메인에서 검색하는 것 까지 넘겅감
# search_form.submit

#result_0 > div > div > div > div.a-fixed-left-grid-col.a-col-right > div.a-row.a-spacing-small

# 결과 페이지를 보자
page = search_form.submit

items = page.search('.s-result-item')

puts "list --"
items.each do |item|
	puts "#{item.css('h2').text}"
	puts "#{item.css('.a-offscreen').text}"


# 더불어서 이것을 저번에 배운 csv로 저장하기
	title = item.css('h2').text
	price = item.css('.a-offscreen').text

	CSV.open("./list.csv", "a+") do |csv|
		csv << [title,price]

	end
end
puts 'success'

# binding.pry
```

```
실행결과:
list --
Western Digital WD Easystore 8TB USB 3.0 External Hard Drive
$207.89
WD 8TB  My Book Desktop External Hard Drive - USB 3.0 - WDBBGB0080HBK-NESN
$184.99
WD Red 8TB NAS Hard Disk Drive - 5400 RPM Class SATA 6 Gb/s 128MB Cache 3.5 Inch - WD80EFZX
$249.00
WD - Easystore 4TB External USB 3.0 Hard Drive - Black



Carrying Case for Western Digital Easystore 8TB External USB 3.0 Hard Drive with Scratch-Resistant Interior Lining and Hard Shell Exterior by USA Gear - Room for Hard Drive plus Accessories
$19.99
WD 8TB My Book Duo Desktop RAID External Hard Drive - USB 3.0 - WDBLWE0080JCH-NESN

[Sponsored]BOVKE Protective Case for Seagate Expansion Desktop,Western Digital WD My Book / Elements Desktop External Hard Drive USB 3.0,2TB 3TB 4TB 5TB 6TB 8TB Carrying Case Storage Travel Bag, Black
[Sponsored]$14.99
[Sponsored]Lacdo EVA Shockproof Carrying Travel Case for 2.5-Inch Portable External Hard Drive, GPS Camera and External Battery Pack
[Sponsored]$7.99
[Sponsored]AmazonBasics Hard Carrying Case for My Passport Essential
[Sponsored]$4.99
WD 4TB Elements Portable External Hard Drive - USB 3.0 - WDBU6Y0040BBK-WESN
$99.99
Summer Infant EasyStore Comfort Tub, Blue
$22.99
WD 4TB Black My Passport  Portable External Hard Drive - USB 3.0 - WDBYFT0040BBK-WESN
$107.14
WD 2TB Elements Portable External Hard Drive - USB 3.0 - WDBU6Y0020BBK-WESN
$69.99
Seagate Expansion 8TB Desktop External Hard Drive USB 3.0 (STEB8000100)
$149.99
Seagate Backup Plus Hub 8TB External Desktop Hard Drive Storage  (STEL8000100)
$149.99
Seagate Backup Plus Hub for Mac 8TB External Desktop Hard Drive (STEM8000400)
$149.99
Seagate 8TB IronWolf NAS SATA 6Gb/s NCQ 256MB Cache 3.5-Inch Internal Hard Drive (ST8000VN0022)
$242.45
success
(list.scv에 해당 정보가 저장된다)
```

아 비싸. 베바고시 통과하고 싶다.





##### rm -rf

recursive (폴더를 삭제할때) force (원래 유닉스시스템은 안파일 없어야 지워지는데 이걸 강제하겠다.)



##### Arttii.rb

```ruby
require "artii"

a = Artii::Base.new font: 'slant'
puts a.asciify 'Bot!'

def asciify(text, font)
	a = Artii::Base.new font: "#{font}"
	puts a.asciify "#{text}"
end

puts '언제나 더불어 입력해서 출력해보기'
puts 'text 입력'
text= gets.chomp!
puts 'font 입력'
font =gets.chomp!

asciify(text,font)
```

```
    ____        __  __
   / __ )____  / /_/ /
  / __  / __ \/ __/ /
 / /_/ / /_/ / /_/_/
/_____/\____/\__(_)

언제나 더불어 입력해서 출력해보기
text 입력
texttt
font 입력
slant
   __            __  __  __
  / /____  _  __/ /_/ /_/ /_
 / __/ _ \| |/_/ __/ __/ __/
/ /_/  __/>  </ /_/ /_/ /_
\__/\___/_/|_|\__/\__/\__/

ubuntu@ubuntu-xenial:/vagrant/day6$


```





SINATRA 빠이염! HELLO RAILS!

https://gorails.com/setup/ubuntu/16.04

여기에 따라서 설치를 한다.



```
To install NodeJS, we're going to add it using the official repository:

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
And now, without further adieu:

gem install rails -v 4.2.9
If you're using rbenv, you'll need to run the following command to make the rails executable available:

rbenv rehash
Now that you've installed Rails, you can run the rails -v command to make sure you have everything installed correctly:

rails -v
# Rails 4.2.9
```





```
ubuntu@ubuntu-xenial:/vagrant/day6$ rails -v
Rails 4.2.9
ubuntu@ubuntu-xenial:/vagrant/day6$ rails new apple
```

```
rails s -b 0.0.0.0
```

```
실행결과:
[2017-12-18 07:42:29] INFO  WEBrick 1.3.1
[2017-12-18 07:42:29] INFO  ruby 2.4.2 (2017-09-14) [x86_64-linux]
[2017-12-18 07:42:29] INFO  WEBrick::HTTPServer#start: pid=16527 port=3000
(localhost:3000 으로 접속하면 rails 기본 페이지가 출력된다.)
```





rails g controller home

```linux
Running via Spring preloader in process 16631
      create  app/controllers/home_controller.rb
      invoke  erb
      create    app/views/home
      invoke  test_unit
      create    test/controllers/home_controller_test.rb
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/home.coffee
      invoke    scss
      create      app/assets/stylesheets/home.scss

```



configration (설정)폴더안의

routes.rb

```ruby
Rails.application.routes.draw do
  ################################################
  root 'home#index'
  get 'home/index'
  
  # 주소요청과정 1
  # 요청을 맨처음 받는 곳
  # get 'home/index' => 'home#index'
  # get 주소로 보내면, => home컨트롤러의 index를 실행하라
  # 이때 index는 view나 erb를 모두 칭한다. 그러니 이름은 같은 것이 좋다.
  # 만약 경로가 같다면, 생략할 수 있다.

  ################################################
```

Route + controller가 원래는 나뉘어져있는건데 저번에 실습한  SINATRA는 이것들이 합쳐진것이다.





home_controller.rb

```ruby
class HomeController < ApplicationController
	def index
	# 주소요청과정 2
		@hihi = "안녕안녕"
	end
end
```



index.erb

```erb
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<h1>안녕하세요!</h1>
<h2><%=@hihi %></h2>
</body>
</html>
```





서버는 localhost:3000에서 돌아가고 있습니다.

얘는 SIANTRA와 다르게 Routing 설정 이외에는 저장만 해도 적용이 바로바로됩니다.