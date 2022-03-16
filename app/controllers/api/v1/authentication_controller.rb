class Api::V1::AuthenticationController < ApiController
    skip_before_action :authenticate_user!
    def create
      user = User.find_by(email: params[:user][:email])
      if user&.valid_password?(params[:user][:password])
        render json: { token: JsonWebToken.encode(sub: user.id) }, status: 200
      else
        render json: { errors: 'User does not exist' }, status: 400
      end
    end
end