require 'rails_helper'

describe OrdersController do

  describe 'GET #new' do
    it "newアクションでnew.html.erbに遷移するか" do
      # 作成したitemの注文に進む
      item = create(:item)
      get :new, params: {  item_id: item.id }
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    # テストデータベースにitemを仮作成
    let(:user) { create(:user) }
    let(:item) { create(:item, user_id: 1) }
    let(:params) { { user_id: user.id, item_id: item.id } }
    context 'ログインしている時' do
      before do
        login user
      end
      context '保存できた時' do
        subject {
          post :create,
          params: params
        }
        it 'データベースにアイテムが追加されたか' do
           expect{ subject }.to change(Order, :count).by(1)
        end

        it '全ての処理が終了後トップページに戻る' do
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end
    context '保存できなかった時' do
      let(:invalid_params) { { user_id: user.id, item_id: item.id } }
       subject {
         post :create,
         params: invalid_params
       }

      it 'データベースに保存されてないこと' do
         expect{ subject }.not_to change(Order, :count)
      end
    end
    # ログインしていない時
    context 'ログインしていない時' do

      it 'ログインしていない場合はログインページヘ飛ばす' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
