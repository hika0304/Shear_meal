class TweetsController < ApplicationController
before_action :authenticate_user!, except: [:index, :search, :show]
before_action :guest_user_restriction, only: [:new, :create, :edit, :update, :destroy]

 def index
   # Ransackの検索オブジェクトを作成# Ransackの検索フォーム用
    @q = Tweet.ransack(params[:q])

   # 結果を取得（重複なし）
    @search_results = @q.result(distinct: true)
  #投稿一覧（すべての投稿）も表示
    @tweets = Tweet.all

     # 検索ワードが入力されたときだけ履歴を保存
   if user_signed_in? && params[:q].present?
    keyword = params[:q].values.reject(&:blank?).join(" ")
    if keyword.present?
      current_user.search_histories.create(keyword: keyword)
    end
   end
 end
   
 def my_posts
  @tweets = current_user.tweets.order(created_at: :desc)  # 自分の投稿だけ取得
 end
 
 def new
   @tweet = Tweet.new(
    age_group: current_user.age_group,
    gender: current_user.gender,
    goal: current_user.goal
  )
 end

 def create
    tweet = Tweet.new(tweets_params)

    tweet.user_id = current_user.id
    
    if tweet.save
        redirect_to :action => "index"
    else
        redirect_to :action => "new"

    end
 end

 def search
  @q = Tweet.ransack(params[:q])
  @search_results = @q.result(distinct: true)
 end


  def show
    @tweet = Tweet.find(params[:id])
  
  end
  
  def edit
    @tweet = Tweet.find(params[:id])

  end

  def update 
    tweet = Tweet.find(params[:id])
    if tweet.update(tweets_params)
      redirect_to :action => "show",:id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end
  

 private
 def tweets_params
    params.require(:tweet).permit(:body, :image, :gender, :weight, :goal, :age_group)
 end

 def guest_user_restriction
  if current_user&.guest?
    redirect_to root_path, alert: "ゲストユーザーはこの操作ができません"
  end
 end


end

