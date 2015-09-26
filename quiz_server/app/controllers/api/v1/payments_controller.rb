class PaymentsController < ApplicationController
require 'webpay'
respond_to :json
    def create
        webpay = WebPay.new('test_secret_4OiaIUaw3eA797P77Cdm35RF')

        # WebPay上での顧客の情報を作成
        customer = webpay.customer.create(card: params['webpay-token'])
        event = Event.find_by(id: params[:event_id])
        if event.nil?  || event.admin_user_id != current_admin_user.id
          return render_fault("不正な操作です")
        end

        amount = Course.find_by(id: event.course_id).price

        # 顧客情報を使って支払い
        webpay.charge.create(
            amount: amount,
            currency: 'jpy',
            customer: customer.id
        )

        #イベントにURL_TOKENをセット
        token = event.set_url_token

        render :json => { :success => true,
                          :info => "決済処理が完了しました",
                          :url_token => token
                        }

        rescue WebPay::ErrorResponse::CardError => e
        # エラーハンドリング。発生する例外の種類がいくつか用意されているので、内容に応じて処理を書く
        render_fault("パラメータが不正です")
    end
end
