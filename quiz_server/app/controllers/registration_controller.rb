class RegistrationController < Devise::RegistrationsController


  #skip_before_filter :verify_authenticity_token,
  #                   :if => Proc.new  { |c| c.request.format == 'application/json' }
 respond_to :json

  def new
    super
  end

  def create
    attr = params.require(:admin_user).permit(:email,:password,:password_confirmation)

    if !AdminUser.exists?(email: attr['email'])
      @admin_user = AdminUser.create(attr)

      render :status => 200,
           :json => { :success => true,
                      :info => "ユーザーの作成に成功しました",
                    }
    else
      failure
    end

  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "ユーザーの作成に失敗しました"
          }
  end
end
