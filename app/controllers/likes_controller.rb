class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_tweet
   before_action :guest_user_restriction, only: [:create, :destroy]


  def create
     # いいねを作成
    current_user.likes.find_or_create_by(tweet: @tweet)
    
     # 最新情報でリロード
  @tweet.reload

    respond_to do |format|
       format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "tweet_#{@tweet.id}_likes",
          partial: "tweets/like_button",
          locals: { tweet: @tweet }
        )
    end
    format.html { redirect_to tweets_path }
    end
  end

  def destroy
    #いいねを削除
     current_user.likes.find_by(tweet: @tweet)&.destroy

      # 最新情報でリロード
  @tweet.reload

     respond_to do |format|
       format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "tweet_#{@tweet.id}_likes",
          partial: "tweets/like_button",
          locals: { tweet: @tweet }
        )
      end
      format.html { redirect_to tweets_path }
    end
      
  end
  
   private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def guest_user_restriction
    if current_user&.guest?
      redirect_to tweets_path, alert: "ゲストユーザーはこの操作を行えません。"
    end
  end 
end

