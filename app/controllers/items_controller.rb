class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_edit_item, only: [:edit]

  def index
    @items = Item.where("order_status = '出品中'")
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
    @items = Item.where("order_status = '出品中'")
  end

  def edit
    render "items/#{params[:name]}"
  end

  def update
    if @item.user.id == current_user.id
      if @item.update(item_params)
        render "items/myitem-detail"
      else
        render "items/edit"
      end
    end
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to action: :index
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :price, :order_status, :item_status, :shipping_fee, :delivery_way, :shipping_area, :estimated_shipping_date, :description, :size, :category_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_edit_item
    @item = Item.find(params[:item_id])
  end

end

