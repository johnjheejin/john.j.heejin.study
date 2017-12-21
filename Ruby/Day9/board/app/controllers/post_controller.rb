class PostController < ApplicationController
before_action :authenticate_user, except: :index
# 항상 검증된 유저인지 확니하라
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

  def editpost
    @id = params[:id]
    @post = Post.find @id

    @title = @post.title
    @content = @post.content
  end

  def update
    @id = params[:id]
    @post = Post.find @id

    @title = params[:title]
    @content = params[:content]

    @post.update(
      title: @title,
      content: @content
      )

    redirect_to "/post/viewpost/#{@id}"
  end

  def deletepost
    
  end

  def delete
    @id = params[:id]

    @post = Post.find @id

    @post.destroy

    redirect_to '/'
  end

end
