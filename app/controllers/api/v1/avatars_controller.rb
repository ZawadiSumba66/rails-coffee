class Api::V1::AvatarsController < ApiController
    def create
        image = params[:avatar][:image]
        avatar = current_user.avatars.create(avatar_params)
        avatar.image.attach(image) if image.present?
        url = Avatar.avatar_url(avatar.image)
        if avatar.save
            render json: { avatar_url: url}, status: 200
        else
            render json: { message: 'An error occured while adding your photo' }, status: 400
        end
    end
    
    def show
        avatar = Avatar.find(params[:id])
        render json: avatar
    end

    def edit
        avatar = Avatar.find(params[:id])
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