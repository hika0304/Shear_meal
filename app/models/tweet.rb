class Tweet < ApplicationRecord
 belongs_to :user
 has_one_attached :image
 
 has_many :likes, dependent: :destroy
 has_many :liked_users, through: :likes, source: :user

 def self.ransackable_attributes(auth_object = nil)
    ["age_group", "body", "created_at", "gender", "goal", "id", "updated_at", "user_id", "weight"]
  end
end
