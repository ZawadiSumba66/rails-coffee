module Api
  module V1
    # authentication controller
    class AuthenticationController < ApiController
      skip_before_action :authenticate_user!
      def create
        user = User.find_by(email: params[:user][:email])
        if user&.valid_password?(params[:user][:password])
          render json: { token: JsonWebToken.encode(sub: user.id) }, status: 200
        else
          render json: { errors: 'Invalid email or password' }, status: 400
        end
      end
    end
  end
end
