require 'rails_helper'

describe ItemsController do

  describe 'GET #new' do
    it "newアクションでnew.html.erbに遷移するか" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'GET #show' do
    it "showアクションで指定のアイテムidページに遷移するか" do
      # テストデータベースにitemを仮作成
      item = create(:item)
      get :show, params: {  id: item }
      expect(assigns(:item)).to eq item
    end
  end
  describe 'GET #index' do
    it "indexアクションで出品中のアイテムのみが表示されるか" do
      # テストデータベースにuser、itemを仮作成
      user = create(:user)
      items = create_list(:item, 5, overrides = {user_id: user.id})
      get :index
      expect(assigns(:items)).to match(items.select{ |item| item.order_status == "出品中"})
    end
  end
end
