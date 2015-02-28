class ConfirmationController < Devise::ConfirmationsController

    respond_to :json

    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?

      if resource.errors.empty?
        set_flash_message(:notice, :confirmed) if is_flashing_format?

        render :status => 200,
           :json => { :success => true,
                      :info => "認証が完了しました"
          }
      else
        render :status => 401,
           :json => { :success => false,
                      :info => "このメールは期限切れです。"
          }
      end
    end
end
