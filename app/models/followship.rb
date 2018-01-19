class Followship < ApplicationRecord
  belongs_to :user
  # 使用 :class_name 這個選項，來告訴 Rails 目標操作的 Model
  belongs_to :following, class name: "User"
end
