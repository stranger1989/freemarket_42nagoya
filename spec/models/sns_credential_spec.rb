require 'rails_helper'
describe SnsCredential do
  describe '#create' do
    it "全ての項目が埋まっていればSNS登録が可能" do
      user = create(:user)
      sns_credential = build(:sns_credential, user_id: user.id)
      expect(sns_credential).to be_valid
    end
    it "uidがないと登録できない" do
      user = create(:user)
      sns_credential = build(:sns_credential, uid: nil, user_id: user.id)
      sns_credential.valid?
      expect(sns_credential.errors[:uid]).to include("入力してください")
    end
    it "providerがないと登録できない" do
      user = create(:user)
      sns_credential = build(:sns_credential, provider: nil, user_id: user.id)
      sns_credential.valid?
      expect(sns_credential.errors[:provider]).to include("入力してください")
    end
  end
end
