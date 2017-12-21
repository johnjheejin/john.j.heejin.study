# Day9

### Comment달아보기

```
rails new ex_comment
```

```
rails g controller post index newpost create
```

```
rails g model post title content comment
```

이제는 조금 익숙해진 (단 몇일만에..) 틀을 간단하게 구성한다.

웹 프로젝트를 만들고

controller로 post에 실릴 페이지를 만들고

데이터 모델을 설계한다



##### emmet은 원래 html코딩을 쉽게하는 것이라서

```div.container``` 를 쓰고 tab을 누르면 

```erb
<div class="container"></div>
```

가 생성된다.



#### comment model을 만들어보자.

##### post:comment 의 관계는 1:n

```
rails g model comment content post_id:integer
```



```
  t.string :content
  t.integer :post_id
```



models/ post.rb

```ruby
class Post < ActiveRecord::Base
	has_many :posts
end
```



models/ comment.rb

```ruby
class Comment < ActiveRecord::Base
	belongs_to :post
end
```



### faker :랜덤 데이터 생성기

```
gem install faker
```

db에 랜덤데이터를 생성해주는거다

##### db/ seeds.rb

```ruby

```



##### 



### 프로젝트 이름과 컴포넌트들의 이름은 중복되지 않는다.



##### 