class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  has_many :search_histories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

   validates :age_group, inclusion: { in: ["10代","20代","30代","40代","50代","60代以上"], allow_nil: true }
  validates :gender, inclusion: { in: ["男性","女性"], allow_nil: true }
  validates :goal, inclusion: { in: ["ダイエット","筋トレ","健康維持"], allow_nil: true }

   def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
   end
   
   def guest?
    email == 'guest@example.com'
  end

end
