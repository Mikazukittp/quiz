class ConfirmationController < Devise::ConfirmationsController

    respond_to :json

    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?

      if resource.errors.empty?
        set_flash_message(:notice, :confirmed) if is_flashing_format?


      else

      end
    end

    def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render :status => 200,
           :json => { :success => true,
                      :info => "認証メールを送信いたしました"
          }
    else
      render :status => 401,
           :json => { :success => false,
                      :info => "メールアドレスが見つかりません"
          }
    end
  end
end
