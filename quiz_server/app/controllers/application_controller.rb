class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # パラメーターからtokenを取得する
  #before_filter :get_token_from_response

  # => トークンによる認証
  #before_action      :authenticate_user_from_token!, if: -> {params[:email].present?}


  #　パラメータからtokenを取得するメソッド
  #def get_token_from_response
   # params[:authenticity_token] = form_authenticity_token
  #end

  #トークンによる認証
  def authenticate_user_from_token!
    user = User.find_by(email: params[:email])
    if Devise.secure_compare(user.try(:authentication_token), params[:token])
      sign_in user, store: false
    end
  end
end
