class RegistrationController < Devise::RegistrationsController
  #skip_before_filter :verify_authenticity_token,
  #                   :if => Proc.new  { |c| c.request.format == 'application/json' }

  prepend_before_filter :require_no_authentication, :only => [ :cancel]

  def new
    super
  end

  def create
    attr = params.require(:admin_user).permit(:email,:name,:password,:password_confirmation)
    if !AdminUser.exists?(email: attr['email'])
      @admin_user = AdminUser.create(attr)

      render_success("ユーザーの作成に完了しました")
    else
      failure
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      sign_in resource_name, resource, bypass: true
      render_success("パスワードの更新に完了しました")
    else
      clean_up_passwords resource
      render_fault("パスワードの更新に失敗しました")
    end
  end

  def failure
    render_fault("ユーザーの作成に失敗しました")
  end
end
