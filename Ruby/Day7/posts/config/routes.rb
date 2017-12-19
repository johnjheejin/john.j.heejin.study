Rails.application.routes.draw do
  root "posts#index"
  get "/new" => "posts#new"

  get "/posts/create"
  get "/posts/read/:id" => "posts#read"
  get "/posts/update/:id" => "posts#update"
  get "/posts/updating/:id" => "posts#updating"
  
  get "/posts/delete/:id" => "posts#delete"
end
