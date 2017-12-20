Rails.application.routes.draw do
  root 'posts#index'

  get 'posts/newpost'

  # get 'posts/create'

  post 'posts/create'

  get 'posts/read/:id' => 'posts#read'

  get 'posts/editpost/:id' => 'posts#editpost'

  # get 'posts/update/:id' => 'posts#update'

  post 'posts/update/:id' => 'posts#update'

  # get 'posts/delete/:id' => 'posts#delete'

  delete 'posts/delete/:id' => 'posts#delete'
end
