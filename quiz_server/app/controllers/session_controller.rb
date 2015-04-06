class SessionController < Devise::SessionsController

  #skip_before_filter :verify_authenticity_token,
  #                   :if => Proc.new  { |c| c.request.format == 'application/json' }
 respond_to :json

  def create
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
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
           }
  end

  def failure
    render_fault("ログインに失敗しました")
  end
end