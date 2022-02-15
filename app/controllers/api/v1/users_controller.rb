class Api::V1::UsersController < ApiController
    skip_before_action :authenticate_user!
    def create
        user = User.create(user_params)
        if user.save
            render json: { token: JsonWebToken.encode(sub: user.id) }
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def edit
        user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user.update(params)
            render json: user, status: 200
        else
            render json: {message: 'An error occurred while updating your profile'}, status: 400
        end
    end

    private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end 
end 