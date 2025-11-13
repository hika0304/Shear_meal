class Users::SessionsController < Devise::SessionsController
 # POST /users/guest_sign_in
  def guest_sign_in
    # ゲスト用ユーザーを取得（事前に作っておくこと）
    user = User.find_by(email: 'guest@example.com')
    # サインイン
    sign_in(user)
    # リダイレクト先（トップページなど）
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
end