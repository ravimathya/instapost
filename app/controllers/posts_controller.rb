class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :is_owner?, only: [:edit, :update, "destroy"]

    def index
        @posts = Post.order('created_at DESC').page(params[:page]).per_page(4)
    end

    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def show
      @post = Post.find(params[:id])
    end

    def upvote

    end

    def downvote

    end

    def create
      @post = current_user.posts.create(post_params)
      if @post.valid?
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        if @post.valid?
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to root_path
    end
      
    private

    def is_owner?
      if Post.find(params[:id]).user != current_user
        redirect_to root_path
      end
    end
    
    def post_params
      params.require(:post).permit(:user_id, :photo, :description)
    end
end
