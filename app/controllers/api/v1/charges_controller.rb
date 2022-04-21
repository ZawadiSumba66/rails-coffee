require 'stripe'
module Api
  module V1
    class ChargesController < ApiController
      def index
        charges = Stripe::Charge.list({ limit: 3 })
        render json: charges, status: 200
      end

      def create
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']

        begin
          customer = Stripe::Customer.create(
            email: current_user.email,
            source: params[:charge][:token]
          )
          Stripe::Charge.create({
                                  customer: customer.id,
                                  amount: params[:charge][:amount],
                                  currency: params[:charge][:currency],
                                  description: params[:charge][:description]
                                })
        rescue Stripe::CardError => e
          render json: { message: e.response }, status: 'not acceptable'
        end
      end
    end
  end
end
