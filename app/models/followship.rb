class Followship < ApplicationRecord
  belongs_to :user
  # 自訂外鍵名稱並使用 class_name 來指定對應的 Model使用
  belongs_to :following, class name: "User"
end
