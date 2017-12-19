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