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

따로 제한은 없지만, 자주 쓰는 것을 따르는 것이 모두에게 마음이 편하다.



##### string interpolation

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

```ruby
answer = answer.capitalize 
answer.capitalize!
```



### Vagrant 환경 구성 및 날씨 확인하는 프로그램 완성하기



##### 가상머신 끄기 halt

```
vagrant halt
```



저번에 Vagrant설치된 경로에서 Vagrantfile을 찾아서 연다. 이후 4567포트를 하나 추가한다.

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



그리고 해당 경로에서 다시 vagrant up을 해서 VM을 구성한다.

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



그리고 다시 varant내부의 ubuntu 에 접속한다

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
ubuntu@ubuntu-xenial:~$ ^C
ubuntu@ubuntu-xenial:~$

```



rbenv 로 2.3.5 설치하는 이유는?

```
rbenv install 2.3.5
```

Ruby 개발 시 더 낮은 버전으로 써야하는 경우에 

바꿔서 실행할 수 있기 때문이다.

```
Downloading ruby-2.3.5.tar.bz2...
```





빠른 개발을 위해서 Interactive Ruby를 잘 쓰자

하나하나 정의할때 마다 되는지 안되는지 짧은 분기별로 알 수 있다.



binding.pry

이거를 쓰니까 안꺼지고 계속 프로그램이 실행되고 있고,

변수를 찾아갈 수 있따.

멈추고 이쯤에서 멈추고 갖고 놀겟다

나올 때는 Ctrl +d를 누르면 빠져나온다

물론, 나머지를 다 실행할거야

binding.pry를 건 시점 기준으로만 가지고 놀 수 있다.



원래 debugger 이것이 있다고 합니다.



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



