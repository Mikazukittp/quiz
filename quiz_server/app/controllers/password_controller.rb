class PasswordController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
       render_success("パスワードの更新が完了しました")
    else
       render_fault("パスワードの更新に失敗しました")
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    extend Devise

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render :action => "show"
    else
    render :action => "show"
    end
  end

  def show
  end
end