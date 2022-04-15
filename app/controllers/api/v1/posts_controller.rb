class Api::V1::PostsController < ApiController
    skip_before_action :authenticate_user!, only: %i[index show]
    def index
       popular = Category.first.posts.all
       latte = Category.second.posts.all
       espresso = Category.third.posts.all
       render json: {popular: popular, latte: latte, espresso: espresso}, status: 200
    end
    def create
        if current_user.admin?
            post = current_user.posts.create(post_params)
            if post.save
            render json: post,  status: 200
            else
            render json: { message: post.errors.full_messages }, status: 400
            end
        end
    end

    def show
        post = Post.find(params[:id])
        render json: post
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            render json: post, status: 200
        else
            render json: {message: 'An error occurred while updating the post'}, status: 400
        end
    end
    
    private
    def post_params
        params.require(:post).permit(:name, :image, :price, :category_id);
    end
end