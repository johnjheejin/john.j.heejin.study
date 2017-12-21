# Day8

### rails의 만들고 지우기

##### rails g 만들기

##### rails d 지우기



### CRUD 기능을 가진 게시판을 만드는 연습을 해주세요 :)

##### 교육제공자가 제공하는 실습환경 접근순서

```
git bash
cd ~
cd /vagrant
vagrant up
vagrant ssh
리눅스 확인
sublime text들어가서 작업하기
```

##### 내가 진행하는 순서  (경로접근이 더 직관적임)

```
윈도우 탐색기로 해당 경로에 들어간다
경로에 접근하여 오른쪽마우스 클릭, Git Bash Here 을 누른다
vagrant up
vagrant ssh
리눅스 확인
sublime text들어가서 작업하기
```



```
mkdir 폴더
cd 폴더
rails new posts
```





```
rails g controller posts index newpost create read update delete
```



```
rails g model post title content
```





### 서버가동 명령어를 쉽게

```
rails s -b 0.0.0.0
```

매번 이렇게 가동하는 서버의 커맨드를 조금 간단하게 해보자

vagrant ~폴더에서 .bashirc를 찾아서 수정하자

```
vi .bashirc
```



```
...
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rails_start='rails s -b 0.0.0.0'
...
```



ESC 후

```
:wq
```



```
source ~/.bashrc
```





자주쓰는 것을 줄여보자

```
    @id = params [:id]
    @post = Post.find @id
```

이걸 계속 쓰게 되는데, 이걸 줄여보자



### matching 시켜보기

* post create
* get read
* put update
* delete delete



### post

#### post 체험해보기

```erb
post 'posts/create'
```

```erb
<form action="/posts/create" method="POST">
```

```ruby
  # protect_from_forgery with: :exception
```

위 과정을 거치면 POST로 보내볼 수 있다.

하지만 맨 마지막에 protect를 주석화 시킨 점이 마음에 걸리는데...



#### CSRF 공격

 원래 사이트를 조작해서 form을 통해 우리가 원하는 자료를 받게 해주는거

##### app/ controllers/ 

```ruby
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
```

이렇게 친절히 설명되어있다.



```ruby
<input type="hidden" name="authenticity_token" value="<%=form_authenticity_token">
```

