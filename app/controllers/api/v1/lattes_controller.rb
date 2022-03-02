class Api::V1::LattesController < ApiController
    def index
        lattes = Latte.all
        render json: lattes, status: 200
    end
    def create
        if current_user.admin?
            latte = current_user.lattes.create(latte_params)
            if latte.save
              render json: latte, status: 200
            end
        end
    end

    def show
        latte = Latte.find(params[:id])
        render json: latte
    end

    private
    def latte_params
        params.require(:latte).permit(:name, :image)
    end
end