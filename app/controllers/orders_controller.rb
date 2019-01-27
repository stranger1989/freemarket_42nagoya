class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
  end

  def new
    @item = Item.find(params[:item_id])
    @order = Order.new()
  end

  def create
    @item = Item.find(params[:item_id])
    begin
      Order.transaction do
        Order.create!(order_params)
        amount = @item.price
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        Payjp::Charge.create(
            :amount => amount,
            :currency => 'jpy',
            :customer => current_user.payment,
            :description => 'メルカリでの購入'
        )
      end
      @item.update(order_status:'売却済')
      @order = Order.find_by(item_id: params[:item_id])
    # クレジット決済がうまくいかなかった時
    rescue Payjp::InvalidRequestError => e
      Rails.logger.debug e.json_body[:error][:message]
      flash[:notice_payment] = "クレジットカードの決済に失敗しました"
      @order = Order.new()
      render action: :new
    # paramsの受け渡しが上手くいかなかった時
    rescue => e
      Rails.logger.debug e.message
      @order = Order.new()
      flash[:notice_payment] = "通信に失敗しました"
      render action: :new
    end
  end

  private
  def order_params
    params.permit(:item_id).merge(user_id:current_user.id)
  end
end
