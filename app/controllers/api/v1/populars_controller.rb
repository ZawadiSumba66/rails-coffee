class Api::V1::PopularsController < ApiController
    def index
        populars = Popular.all
        render json: populars, status: 200
    end
    def create
        if current_user.admin?
            popular = current_user.populars.create(popular_params)
            if popular.save
              render json: popular, status: 200
            end
        end
    end

    def show
        popular = Popular.find(params[:id])
        render json: popular
    end

    private
    def popular_params
        params.require(:popular).permit(:name, :image)
    end
end