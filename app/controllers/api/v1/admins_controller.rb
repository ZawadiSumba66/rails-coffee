class Api::V1::AdminsController < ApiController
    skip_before_action :authenticate_user!
    def create
        admin = Admin.create(admin_params)
        if admin.save
            render json: admin
        end
    end
    def admin_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end