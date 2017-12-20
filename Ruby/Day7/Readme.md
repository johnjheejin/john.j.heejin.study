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



### rails_db

rails에서 간단하게 db를 만들 수 있는 gem

localhost:3000/rails/db 에서 db정보를 조회하고 관리할 수 있다.



### rails troubleshooting

##### routes 만들어라

```
No route matches [GET] "/post/create"
```

##### controller 지정해라

```
The action 'create' could not be found for PostController
```

##### view 만들어라

```
Missing template post/create, application/create with {:locale=>[:en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}. Searched in: * "/vagrant/day7/post/app/views"
```





### 이제껏 만든 프로젝트들 모아보자:반복

##### routes.rb에 받은 주소에 출력할 거 정해주기

##### home_controller.rb 에서 정의하기

##### 페이지.html.erb 를 만들어 view를 만들기



### Posting system만들기



##### db를 위한 모델 만들기

```
rails g model newpost
```

```
Running via Spring preloader in process 18174
      invoke  active_record
      create    db/migrate/20171219042938_create_newposts.rb
      create    app/models/newpost.rb
      invoke    test_unit
      create      test/models/newpost_test.rb
      create      test/fixtures/newposts.yml
```



##### 20171219042938_create_newposts.rb

```
class CreateNewposts < ActiveRecord::Migration
  def change
    create_table :newposts do |t|
############################################

t.string :title
# column이 title이라는 string을 만든다.
t.string :contents
# column이 contents이라는 string을 만든다.

############################################
      t.timestamps 
      # null: false
    end
  end
end
```



##### model을 db로 migration하기

```
rake db:migrate
```

```
== 20171219042938 CreateNewposts: migrating ===================================
-- create_table(:newposts)
   -> 0.0038s
== 20171219042938 CreateNewposts: migrated (0.0038s) ==========================
```



### CRUD

Create, Read, Update, Delete



##### gemfile

```ruby
source 'https://rubygems.org'

####################################
gem 'rails_db'
####################################
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
```





##### post/ app/ controlls/ post_controller.rb

```ruby
class PostController < ApplicationController
  def index
  	@posts = Newpost.all
  end
  def new
  	
  end
  def create
  	@title = params[:title]
  	@contents = params[:content]

  	Newpost.create(title: @title, contents: @contents)
  	# @post = Newpost.new
  	# @post.title = @title
  	# @post.contents = @contents
  	# @post.save


  end
  def show
  	@id = params[:id]
  	#routes.rb에서 id로 설정햇음
  	@post = Newpost.find @id
  end
  def delete
  	@id = params[:id]
	@post = Newpost.find @id

	@post.destroy

	redirect_to '/'

  end
  def edit
  	@id = params[:id]
	@edit_post = Newpost.find @id
  end
  def update
  	params[:title]
  	params[:content]

  	@id = params[:id]
	@update_post = Newpost.find @id

	update_post.update(title: params[:title], contents: params[:content])
	# @update_post.title = params[:title]
	# @update_post.contents = params[:content]
	# @update_post.save

	redirect_to "/post/show/#{@id}"
  end
end
```



##### config/ routes.rb

```ruby
Rails.application.routes.draw do
  root 'post#index'
  get '/new' => 'post#new'
  
  get '/post/create'

  get '/post/show/:id' => 'post#show'

  get '/post/delete/:id'  => 'post#delete'

  get '/post/edit/:id'  => 'post#edit'

  get '/post/update/:id'  => 'post#update'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
```



##### views/ post/ index.html.erb

```erb
<h1>Post#index</h1>
<p>Find me in app/views/post/index.html.erb</p>
<hr>
<% @posts.each do |post| 
%>
<%=post.title%>
<br>
<%=post.contents%> <br>
<a href="/post/show/<%=post.id%>">see</a>
<a href="/post/delete/<%=post.id%>">delete</a>
<a href="/post/edit/<%=post.id%>">edit</a>
<hr>
<% end
%>
```



##### views/ post/ new.html.erb

```erb
<h1>Post#new</h1>
<hr>
<form action="/post/create">
  <div class="form-group">
    <label for="exampleInputEmail1">제목</label>
    <input name="title" type="text" class="form-control" id="title" placeholder="Title here">
  </div>

  <div class="form-group">
    <label for="exampleInputPassword1">내용</label>
    <input name="content" type="text" class="form-control" id="contents" placeholder="Type here">
  </div>
  <div class="form-check">


  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```



##### views/ post/ create.html.erb

```erb
<h1>created like this</h1>
<br>
<%=@title%>
<hr>
<%=@contents%>
```



##### views/ post/ show.html.erb

```erb
<h1> this is show</h1>
<%=@post%>
<br>
번호 <%=@post.id%>의 글
<br>
<h2><%=@post.title%></h2>
<hr><br>
<%=@post.contents%>
```



##### views/ post/ edit.html.erb

```erb
<h1>Post#edit</h1>
<hr>
<form action="/post/update/<%=@edit_post.id%>">
  <div class="form-group">
    <label for="exampleInputEmail1">제목</label>
    <input name="title" type="text" class="form-control" id="title" placeholder="Title here" value="<%=@edit_post.title%>">
  </div>

  <div class="form-group">
    <label for="exampleInputPassword1">내용</label>
    <input name="content" type="text" class="form-control" id="contents" placeholder="Type here" value="<%=@edit_post.contents%>">
  </div>
  <div class="form-check">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```





views/ post/



orm 객체관계매핑





코드가 위아래로 벌어지는건 좋은 습관입니다

한줄로 만드는건 가독성이 똥이라 안좋은겁니다.







다시 만들어보기

```
rails new posts
```

```
rails g controller posts index
```

```erb
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
```

```erb
	<div class="container">
	<%= yield %>
	</div>
```

```erb
root 'posts/index'
get '/new' => 'posts#new'
```

```erb
<h1>Posts#new</h1>
<form action="/posts/create">
  <div class="form-group">
    <label for="exampleInputEmail1">제목</label>
    <input name="title" type="text" class="form-control" id="title" placeholder="Title here">
  </div>

  <div class="form-group">
    <label for="exampleInputPassword1">내용</label>
    <input name="content" type="text" class="form-control" id="contents" placeholder="Type here">
  </div>
  <div class="form-check">


  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```





```
####################################
gem 'rails_db'
####################################
```

```
bundle
```

```
rails g model post
```

```
    	#########################
    	t.string :title
    	t.string :contents
    	#########################
```

```
rake db:migrate
```

```
  	@title = params[:title]
  	@content = params[:content]

  	Post.create(
  		title: @title,
  		contents: @content
  		)
  	redirect_to '/'
```





db를 잘못 만들었을 경우

```
rake db:drop
```

이후 다시 migrate





그리고 posts를 다시 만들며 복습했다.