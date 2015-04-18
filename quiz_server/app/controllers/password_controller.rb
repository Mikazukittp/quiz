class PasswordController < Devise::PasswordsController

  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
       render :status => 200,
            :json => { :success => true,
                          :info => "メール送りました",
                        }
    else
        render :status => 401,
               :json => { :success => false,
                          :info => "メールアドレスが一致しません"
              }
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    extend Devise

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render :status => 200,
            :json => { :success => true,
                          :info => "パスワードの変更完了",
                        }

    else
    render :status => 401,
               :json => { :success => false,
                          :info => "tokenの値が正しくありません"
              }
    end
  end
end