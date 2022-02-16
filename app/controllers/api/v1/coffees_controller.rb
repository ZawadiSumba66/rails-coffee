class Api::V1::CoffeeController < ApiController
    def create
        coffee = current_user.coffee.create(coffee_params)
        if coffee.save
           render json: coffee,  status: 200
        else
           render json: { message: coffee.errors.full_messages }, status: 400
        end
    end

    def show
        coffee = Coffee.find(params[:id])
        render json: coffee
    end
    
    private
    def coffee_params
        params.(:coffee).permit(:size, :milk, :quantity, :topping, :price);
    end
end