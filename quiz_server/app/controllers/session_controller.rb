class SessionController < Devise::SessionsController

  #skip_before_filter :verify_authenticity_token,
  #                   :if => Proc.new  { |c| c.request.format == 'application/json' }

  prepend_before_filter :require_no_authentication, only: [:new, :create]
  prepend_before_filter :allow_params_authentication!, only: :create
  skip_before_filter :verify_signed_out_user
  prepend_before_filter only: [:create, :destroy] { request.env["devise.skip_timeout"] = true }

  def create
    require_no_authentication
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    resource.ensure_authentication_token

    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :admin_user => current_admin_user,
                      :auth_token => current_admin_user.authentication_token }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_admin_user.update_column(:authentication_token, nil)
    sign_out
    render_success("ログアウトしました")
  end

  def failure
    render_fault("ログインに失敗しました")
  end

  private

  def require_no_authentication
    if current_admin_user
      render :json => current_admin_user
      return
    end
  end

end