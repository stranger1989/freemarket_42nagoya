class SnsCredential < ApplicationRecord
  validates :uid, presence: true
  validates :provider, presence: true
end
