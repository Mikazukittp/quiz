class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  #before_filter :restrict_access

  # パラメーターからtokenを取得する
  before_filter :get_token_from_response

  # => トークンによる認証
  before_action      :authenticate_user_from_token!, if: -> {params[:email].present?}

  # 例外ハンドル
  if !Rails.env.development?
    rescue_from Exception,                        with: :handle_500
    rescue_from ActiveRecord::RecordNotFound,     with: :handle_404
    rescue_from ActionController::RoutingError,   with: :handle_404
  end

  #　パラメータからtokenを取得するメソッド
  def get_token_from_response
    params[:authenticity_token] = form_authenticity_token
  end

  def after_sign_out_path_for(resource)
    '/admin'
  end

  def after_sign_in_path_for(resource)
    events_path # ログイン後に遷移したいパス
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

  def handle_500
    render :status => 500,
           :json => {:success => false,
                     :info => "Internal Server Error"}
  end

  def handle_404
    render :status => 404,
           :json => {:success => false,
                     :info => "routing error"}
  end

  def handle_404_denied
    render :status => 404,
           :json => {:success => false,
                     :info => "denied"}
  end

  private
  def restrict_access
    api_key = ApiKey.find_by_access_token(request.headers[:HTTP_ACCESS_TOKEN])
    handle_404_denied unless api_key
  end

  protected

  def json_request?
    request.format.json?
  end
end
