class PostController < ApplicationController
  def newpost
  end

  def create
    @title = params[:title]
    @content = params[:content]
    Post.create(
      title: @title,
      content: @content
      )
    redirect_to '/'
  end

  def viewpost
    @id = params[:id]
    @post = Post.find @id

    @title = @post.title
    @content = @post.content

    @comments = @post.comments
  end

  def create_comment
    @post_id = params[:id]
    @comment = params[:comment]


    Comment.create(
      post_id: @post_id,
      comment: @comment
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
  redirect_to '/'
  end

  def delete
  end
end
