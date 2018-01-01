class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  has_many :restaurants, through: :comments
  
  def admin?
    self.role == "admin"
  end
end
