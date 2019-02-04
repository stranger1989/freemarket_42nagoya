class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_search_val, only: [:index, :show, :create, :search]

  def index
    @pickup_category_items_1 = display_category("1")
    @pickup_category_items_2 = display_category("2")
    @pickup_brand_items_1 = display_brand("シャネル")
    @pickup_brand_items_2 = display_brand("ナイキ")
  end

  def search
    @q = Item.search(search_params)
    set_serchitems_and_count(@q)
  end

  def new
    @item = Item.new
  end

  def create
    begin
      Item.transaction do
      # ブランドをデータベースから検索
        search_brand_id = ""
        brand_id = item_params[:brand_id]
        category_id = item_params[:category_id]

        if brand_id.present?
          search_brand = Brand.where("name LIKE(?)", brand_id)
          search_brand_id = search_brand[0].id if search_brand != []
        end

        if search_brand_id.present?
          # もしブランドがデータベース内に見つかった時
          # カテゴリと紐付いているブランドが同一か確認
          session[:final_params] = add_brand(item_params, search_brand_id)
          search_category_id = CategoryBrand.where("brand_id LIKE(?) and category_id LIKE(?)", session[:final_params][:brand_id], category_id)
          # カテゴリブランドが紐付いていない時、中間テーブルに登録
          CategoryBrand.create!(brand_id: session[:final_params][:brand_id], category_id: category_id) if search_category_id.empty?
        else
          # もしブランドがデータベースになかった時
          if brand_id.present?
            @brand_id = Brand.create!(name: brand_id).id
            CategoryBrand.create!(brand_id: @brand_id, category_id: category_id)
          else
            @brand_id = nil
          end
          session[:final_params] = add_brand(item_params, @brand_id)
        end
      end
      # brand-categoryの受け渡しがうまくいったら、アイテムを生成
        @item = Item.new(session[:final_params])
        session[:final_params] = nil
        if @item.save
          redirect_to root_path
        else
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

  def display_category(category_parent_id)
    Item.joins(:category).where("categories.ancestry LIKE ?", "#{category_parent_id}%").order("created_at DESC").page(params[:page]).per(4)
  end

  def display_brand(brand_name)
    Item.joins(:brand).where("brands.name LIKE ?", "%#{brand_name}%").order("created_at DESC").page(params[:page]).per(4)
  end

  def set_search_val
    @q = Item.ransack(params[:q])
    set_serchitems_and_count(@q)
  end

  def search_params
    params.require(:q).permit(:name_or_description_cont)
  end

  def set_serchitems_and_count(search_query)
    @categories = Category.all
    @items = search_query.result.includes(:category, :brand).page(params[:page]).per(48)
    @count = @items.total_count
  end

end

