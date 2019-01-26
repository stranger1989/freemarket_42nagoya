class ItemsController < ApplicationController
  before_action :set_all_items, only: [:index, :show]
  before_action :set_item, only: [:show]
  before_action :authenticate_user!, only: [:create]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :price, :order_status, :item_status, :shipping_fee, :delivery_way, :shipping_area, :estimated_shipping_date, :description, :size).merge(user_id: current_user.id)
  end

  def set_all_items
    @items = Item.where("order_status = '出品中'")
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
