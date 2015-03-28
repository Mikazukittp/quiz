class PaymentsController < ApplicationController
require 'webpay'
respond_to :json
    def purchase
        webpay = WebPay.new('test_secret_6ltbY2dN2cXQ6JzfqKawP4ze')

        # WebPay上での顧客の情報を作成
        customer = webpay.customer.create(card: params['webpay-token'])

        # 顧客情報を使って支払い
        webpay.charge.create(
            amount: 10_000,
            currency: 'jpy',
            customer: customer.id
        )
        render :json => {success: true}
        rescue WebPay::ErrorResponse::CardError => e
            # エラーハンドリング。発生する例外の種類がいくつか用意されているので、内容に応じて処理を書く
        end
end
