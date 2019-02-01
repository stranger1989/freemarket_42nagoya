class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @items = Item.where("order_status = '出品中'")
  end

  def new
    @item = Item.new
  end

  def create
    begin
      Item.transaction do
        if item_params[:brand_id] == ""
          # ブランドに何も入力されていないとき、ブランドなしで登録
          session[:final_params] = item_params
        else
        # ブランドに文字列が入力されている時
        # ブランドをデータベースから検索
          search_brand_id = ""
          search_brand = Brand.where("name LIKE(?)", item_params[:brand_id])
          search_brand_id = search_brand[0].id if search_brand != []
          if search_brand_id != ""
            # もしブランドがデータベース内に見つかった時
            # カテゴリと紐付いているブランドが同一か確認
            session[:final_params] = add_brand(item_params, search_brand_id)
            search_category_id = CategoryBrand.where("brand_id LIKE(?) and category_id LIKE(?)", session[:final_params][:brand_id], item_params[:category_id])
            # カテゴリブランドが紐付いていない時、中間テーブルに登録
            CategoryBrand.create!(brand_id: session[:final_params][:brand_id], category_id: item_params[:category_id]) if search_category_id.empty?
          else
            # もしブランドがデータベースになかった時
            @brand = Brand.create!(name: item_params[:brand_id])
            CategoryBrand.create!(brand_id: @brand.id, category_id: item_params[:category_id])
            session[:final_params] = add_brand(item_params, @brand.id)
          end
        end
      end
      # brand-categoryの受け渡しがうまくいったら、アイテムを生成
        @item = Item.new(session[:final_params])
        if @item.save
          session[:final_params] = nil
          redirect_to root_path
        else
          session[:final_params] = nil
          render :new
        end
    rescue => e
      # brand-categoryの受け渡しが一つでも上手くいかなかった時
      # 全てロールバックさせる
      Rails.logger.debug e.message
      flash[:notice_brand_registration] = "ブランドの登録に失敗しました"
      @item = Item.new(item_params)
      render :new
    end
  end

  def show
    @items = Item.where("order_status = '出品中'")
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :price, :order_status, :item_status, :shipping_fee, :delivery_way, :shipping_area, :estimated_shipping_date, :description, :size, :category_id, :brand_id).merge(user_id: current_user.id)
  end

  def add_brand(params_no_brand, brand_id)
    params_no_brand.merge(brand_id: brand_id)
  end

end

