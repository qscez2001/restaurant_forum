class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader

   # 「使用者評論很多餐廳」的多對多關聯
  has_many :comments
  has_many :restaurants, through: :comments, dependent: :restrict_with_error
  
  # 「使用者收藏很多餐廳」的多對多關聯
  # 讓 User 物件可以得到 object.favorites 等關聯方法
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  def admin?
    self.role == "admin"
  end
end
