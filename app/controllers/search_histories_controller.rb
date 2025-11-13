class SearchHistoriesController < ApplicationController
  before_action :authenticate_user!
 def destroy
  history = current_user.search_histories.find(params[:id])
    history.destroy
    redirect_to tweets_path, notice: "検索履歴を削除しました。"
  end
end
