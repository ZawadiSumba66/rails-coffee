class Api::V1::AvatarController < ApiController
    def create
        avatar = current_user.avatar.create(avatar_params)
        avatar.image.attach(image) if image.present?
        url = Avatar.image_url(avatar.image)
        if avatar.save
            render json: { avatar_url: url }, status: 200
        end
    end

    def edit
        avatar =  Avatar.find(params[:id])
    end

    def update
        avatar =  Avatar.find(params[:id])
        if avatar.update(params)
            render json: avatar, status: 200
        else
            render json: {message: 'An error occurred while updating your avatar'}, status: 400
        end
    end

    def destroy
        avatar = Avatar.find(params[:id]) 
        if avatar.destroy(params)
            render json: {message: 'Avatar successfully deleted'}, status: 200
        else
            render json: {message: 'An error occurred while removing youravatar'}, status: 400
        end
    end

    private
    def avatar_params
        params.require(:avatar).permit(:image)
    end
end