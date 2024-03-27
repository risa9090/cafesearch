class PostsController < ApplicationController
    protect_from_forgery

    before_action :authenticate_user!

    def index
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
    end

    def new
        @post = Post.new
    end

    def list   
        if params[:search] == nil
            @posts= Post.all
        elsif params[:search] == ''
            @posts= Post.all
        else
            #部分検索
            @posts = Post.where("store LIKE ? ",'%' + params[:search] + '%')
        end
    end

    def hunniki1
        @posts = Post.where(category:"hunniki1")
    end
    def hunniki2
        @posts = Post.where(category:"hunniki2")
    end
    def hunniki3
        @posts = Post.where(category:"hunniki3")
    end
    def hunniki4
        @posts = Post.where(category:"hunniki4")
    end
    def hunniki5
        @posts = Post.where(category:"hunniki5")
    end
    def hunniki6
        @posts = Post.where(category:"hunniki6")
    end
    def hunniki7
        @posts = Post.where(category:"hunniki7")
    end
    def hunniki8
        @posts = Post.where(category:"hunniki8")
    end
    def hunniki9
        @posts = Post.where(category:"hunniki9")
    end
    
    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end
    
    def show
        @post = Post.find(params[:id])
    end


    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            redirect_to :action => "show", :id => post.id
        else
            redirect_to :action => "new"
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :list
    end
    
    private
    def post_params
        params.require(:post).permit(:store, :category, :menu, :comment, :image)
    end

end
