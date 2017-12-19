class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end
  def new
  end

  def create
  	@title = params[:title]
  	@content = params[:content]

  	Post.create(
  		title: @title,
  		contents: @content
  		)
  	redirect_to '/'
  end
  def read
  	@id = params[:id]

  	@post = Post.find @id
  end
  def update
  	@id = params[:id]

	@post = Post.find @id
  end
  def updating
  	@title = params[:title]
  	@content = params[:content]

  	@id = params[:id]

	@post = Post.find @id

	@post.update(
		title: @title,
		contents: @content
		)

	redirect_to "/posts/read/#{@id}"
  end
  def delete
  	@id = params[:id]

  	@post = Post.find @id

  	@post.destroy

	redirect_to '/'
  end
end
