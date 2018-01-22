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

  # 「使用者like很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
  
  # 讓 User 可以找到他追蹤的人
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 讓 User 可以找到他的追蹤者
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # User 可以找到他加入的好友
  has_many :friendships, dependent: :destroy
  has_many :friendings, through: :friendships

  # User 可以找到加入他的好友
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friending_id"
  has_many :frienders, through: :inverse_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friending?(user)
    self.friendings.include?(user)
  end

end
