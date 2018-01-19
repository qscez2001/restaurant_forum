class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  # 如果應用程式的邏輯允許「未分類」的 Restaurant 資料，
  # 你就需要在 belongs_to 的宣告後，加上 optional: true 的設定
  belongs_to :category
  # 加上 dependent: :destroy，這樣一來，以後刪除 Restaurant 時，就可以一併刪掉關聯的評論
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 我們在 Restaurant class 裡宣告了一個 instance method，
  # 因此這個方法需要被串接在 Restaurant 實例之後使用；
  # 另外，也需要傳入 User 物件，才有足夠的資料在 favorites table 上進行查詢。
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
