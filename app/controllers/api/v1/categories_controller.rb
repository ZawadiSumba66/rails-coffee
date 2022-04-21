module Api
  module V1
    class CategoriesController < ApiController
      skip_before_action :authenticate_user!
      def index
        categories = Category.all
        render json: categories, status: 200
      end

      def create
        return unless current_user.admin?

        category = current_user.categories.create(category_params)
        if category.save
          render json: category, status: 200
        else
          render json: { message: category.errors.full_messages }, status: 400
        end
      end

      def show
        category = Category.find(params[:id])
        render json: category
      end

      private

      def category_params
        params.require(:category).permit(:title)
      end
    end
  end
end
