class UsersController < ApplicationController
   before_action :authenticate_user!
  
  def show
    @user = current_user
    @liked_tweets = @user.liked_tweets.includes(:user)
  end

  def edit
     @user = current_user
  end

  def update
     @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit, alert: "更新に失敗しました。"
    end
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar_url, :age_group, :gender, :goal)
  end
end
