class Api::V1::EspressosController < ApiController
    def index
        espressos = Espresso.all
        render json: espressos, status: 200
    end
    def create
        if current_user.admin?
            espresso = current_user.espressos.create(espresso_params)
            if espresso.save
              render json: espresso, status: 200
            end
        end
    end

    def show
        espresso = Espresso.find(params[:id])
        render json: espresso
    end

    private
    def espresso_params
        params.require(:espresso).permit(:name, :image)
    end
end