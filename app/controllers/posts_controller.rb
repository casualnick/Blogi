class PostsController < ApplicationController
    before_action :set_user, except: :index
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authenticate_login, only: [:new]

    def index
        @posts = Post.all
        @posts.each do |post|
            @user = User.find(post.user_id)
        end
    end

    def show
        @posts = @user.posts
    end

    def new
        @post = @user.posts.new
    end

    def create
        @post = @user.posts.create!(post_params)
        redirect_to home_path, notice: 'Your post has been created successfully' 

    end

    def update
        @post.update!(post_params)
        redirect_to @user, notice: 'Your post has been updated successfully' 

    end

    def destroy
        @post.destroy!
        
        redirect_to home_path, notice: 'Your post has been deleted successfully' 

    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end

    def set_post
        @post = @user.posts.find_by(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
