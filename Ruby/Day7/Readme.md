# Day7

Controller + Action



### Start!

##### 프로젝트 생성

새롭게 rails프로젝트를 생성하여 어제것을 복습합니다.

Git Bash를 통해 vagrant경로에 접근해 vagrant를 실행하고, 새로운 프로젝트 경로를 정해 이를 생성한다.

```
rails new start
```

```
실행결과:
...
Bundle complete! 12 Gemfile dependencies, 60 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
         run  bundle exec spring binstub --all
* bin/rake: spring inserted
* bin/rails: spring inserted
```



##### 컨트롤러 및 생성

```
rails g controller home index
```

```
실행결과:
Running via Spring preloader in process 17344
      create  app/controllers/home_controller.rb
       route  get 'home/index'
      invoke  erb
      create    app/views/home
      create    app/views/home/index.html.erb
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



##### app/ views/ home/ index.html.erb 에 작성해보기

```erb
<h1>Home#index</h1>
<p>Find me in app/views/home/index.html.erb</p>
<h1>rails를 시작해보자.</h1>
```

* 원래 있던 html태그들이 사라지고 없다는 점을 알 수 있다.



이후 vagrant 환경에서

```
rails s -b 0.0.0.0
```

```
localhost:3000 실행결과:
Home#index (h1태그)
Find me in app/views/home/index.html.erb
rails를 시작해보자. (h1태그)
```



### 기반 페이지를 구성하자

##### views/ layouts/ application.html.erb 의 생김새

```erb
<!DOCTYPE html>
<html>
<head>
  <title>Start</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
```



### 새로운 페이지를 만들어보자

#### 1 routes.rb 에 get 했을때 어디로 보낼지 정하자

##### config/ routes.rb

```ruby
Rails.application.routes.draw do
  root 'home#index'
  # get '/' => 'home#index' 를 줄인 것. 
  get '/welcome' => 'home#welcome' 
  # /welcome으로 요청을 보낼 때 home의 welcome으로 보낼거다
  ...
end
```

#### 2 home_controller.erb 에 보내는 곳을 정의하자

##### controllers/ home_controller.erb

```erb
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
end
```

#### 3 보내는 곳의 view를 정의하자

##### views/ home/ index.html.erb

```erb
<h1>Home#index</h1>
<p>Find me in app/views/home/index.html.erb</p>

<form action="/welcome">
	<input type="text" name="user">
	<input type="submit" value="전송">
</form>
```

##### views/ home/ welcome.html.erb

```erb
<h1>Home#welcome</h1>
<p>welcome, <%=@user %></p>
```



#### (4) 기본 페이지를 구성하자

```erb
<!DOCTYPE html>
<html>
<head>
  <title>Start</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>
<h3>common layouts</h3>
<p>pages list.</p>
<a href="/">home</a><br>
<a href="/welcome">welcome</a><br>
<hr>
<%= yield %>

</body>
</html>
```



```
localhost:3000 실행결과:
Home#index (h1 태그)
Find me in app/views/home/index.html.erb 
(입력폼)(전송 버튼)
```

```
localhost:3000 에서 입력폼에 user 입력 후 전송버튼을 누른 결과:
(localhost:3000/welcome?user=user)
Home#welcome (h1 태그)
welcome, user
```

