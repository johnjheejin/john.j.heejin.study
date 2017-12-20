class PostsController < ApplicationController

  before_action :postset, only: [:read, :editpost, :update, :delete]
  #저기 실행되기 전에 꼭 이걸 실행하고 해라.

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

    redirect_to '/'
  end

  def read

  end

  def editpost


    @title = @post.title
    @content = @post.content
  end

  def update


    @title = params[:title]
    @content = params[:content]

    @post.update(
      title: @title, 
      content: @content
      )

    # redirect_to "/posts/read/#{@id}"
  end

  def delete

    @post.destroy
    #제거할때 이걸 쓰더라고;;

    redirect_to '/'
  end

  private
    def postset
      @id = params[:id]
      @post = Post.find @id    
    end
end
