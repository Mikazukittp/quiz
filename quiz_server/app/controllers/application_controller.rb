class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token

  # パラメーターからtokenを取得する
  before_filter :get_token_from_response

  # => トークンによる認証
  before_action      :authenticate_user_from_token!, if: -> {params[:email].present?}


  #　パラメータからtokenを取得するメソッド
  def get_token_from_response
    params[:authenticity_token] = form_authenticity_token
  end

  #トークンによる認証
  def authenticate_user_from_token!
    user = User.find_by(email: params[:email])
    if Devise.secure_compare(user.try(:authentication_token), params[:token])
      sign_in user, store: false
    end
  end

  def render_success(info)
    render :status => 200,
           :json => { :success => true,
                      :info => info,
                      }
  end

  def render_fault(info)
    render :status => 401,
           :json => { :success => false,
                      :info => info,
                    }
  end


  protected

  def json_request?
    request.format.json?
  end
end
