class OrdersController < ApplicationController
  include Pagy::Backend

  def index
    render json: pagy(Repositories::OrderRepository.all)
  end

  def create
    order = Order.create(order_params)

    if order.save
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entitiy
    end
  end

  private

  def order_params
    params.require(:order).permit(:merchant_reference, :shopper_reference, :amount)
  end
end
