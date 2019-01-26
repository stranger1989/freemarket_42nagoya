class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create]
  before_action :set_item, only: [:new, :create]

  def new
    @order = Order.new()
  end

  def create
    Order.create(order_params)
    amount = @item.price
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
        :amount => amount,
        :currency => 'jpy',
        :customer => current_user.payment,
        :description => 'メルカリでの購入'
    )
    @item.update(order_status:'売却済')
    redirect_to root_path
  end

  private
  def order_params
    params.permit(:item_id).merge(user_id:current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
