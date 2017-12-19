Rails.application.routes.draw do
  root 'home#index'
  # get '/' => 'home#index' 를 줄인 것. 
  get '/welcome' => 'home#welcome' 
  # /welcome으로 요청을 보낼 때 home의 welcome으로 보낼거다
  get '/lunch_menu' => 'home#lunch_menu'
  # 점심메뉴 골라주기
  get '/lol_info' => 'home#lol_info'
  # lol 전적가져오기
end
