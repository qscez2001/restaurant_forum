class Followship < ApplicationRecord
  belongs_to :user
  # 自訂外鍵名稱並使用 class_name 來指定對應的 Model使用
  belongs_to :following, class_name: "User"

  # 限制「每個 User 只能追蹤另一個 User 一次」，從資料表的角度來描述，
  # 就是「特定的 user_id 下，只能有一個 followings_id」
  # https://rails.ruby.tw/active_record_validations.html#uniqueness

  validates :following_id, uniqueness: { scope: :user_id }
end
