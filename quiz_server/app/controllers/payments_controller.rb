class PaymentsController < ApplicationController
require 'webpay'
respond_to :json
    def create
        webpay = WebPay.new('test_secret_6ltbY2dN2cXQ6JzfqKawP4ze')

        # WebPay上での顧客の情報を作成
        customer = webpay.customer.create(card: params['webpay-token'])

        p root_url + url_token

        # 顧客情報を使って支払い
        webpay.charge.create(
            amount: 10_000,
            currency: 'jpy',
            customer: customer.id
        )


        set_url_to_event(current_admin_user.id)



        render_sccess("支払いが完了しました")
        rescue WebPay::ErrorResponse::CardError => e
        # エラーハンドリング。発生する例外の種類がいくつか用意されているので、内容に応じて処理を書く
        render_fault("パラメータが不正です")
    end

    def set_url_to_event(admin_id)
        #url = root_url(:only_path => false) + "answers/new/"
        url_token = SecureRandom.urlsafe_base64
        Event.find_by(id: admin_id).update(url_token:url_token)
    end


end
