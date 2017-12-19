# Day7

Controller + Action



### Start!

##### 프로젝트 생성

새롭게 rails프로젝트를 생성하여 어제것을 복습합니다.

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

