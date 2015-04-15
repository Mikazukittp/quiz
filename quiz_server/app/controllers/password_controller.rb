class PasswordController < Devise::PasswordsController

  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
       render_success("パスワードの再送が完了しました")
    else
        render_fault("パスワードの再送に失敗しました")
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    extend Devise

    p resource

    p resource.errors

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render_success("パスワードの更新が完了しました")
    else
    render_fault("パスワードの更新に失敗しました")
    end
  end
end