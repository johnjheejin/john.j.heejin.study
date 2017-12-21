class PostController < ApplicationController
  def index
  	@posts = Post.all
  end

  def newpost
  end

  def create
  	@title = params[:title]
  	@content = params[:content]

  	Post.create(
  		title: @title,
  		content: @content
  		)
  end
  def viewpost
  	@id = params[:id]
  	@post = Post.find @id

  	@post_comments = @post.comments
  end
  def create_postcomment
  	@post_id = params[:id]
  	@content = params[:content]


  	Comment.create(
  		post_id: @post_id.to_i,
  		content: @content
  		)

	redirect_to :back

	# for rails 5~
	# redirect_back(fallback_location: "/post/viewpost/#{@id}")

  end
end
