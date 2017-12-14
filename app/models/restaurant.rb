class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  # 如果應用程式的邏輯允許「未分類」的 Restaurant 資料，
  # 你就需要在 belongs_to 的宣告後，加上 optional: true 的設定
  belongs_to :category
end
