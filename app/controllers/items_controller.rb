class ItemsController < ApplicationController


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

end
