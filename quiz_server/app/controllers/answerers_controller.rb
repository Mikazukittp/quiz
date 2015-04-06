class AnswerersController < ApplicationController
    def create
        answerer = Answerer.create(event_id:params[:event_id],name: params[:name])
        #ユーザートークンの発行
        user_token = SecureRandom.uuid
        answerer.update_attributes(:user_token => user_token)
        cookies[:session_key] = { :value => user_token, :expires => 1.days.from_now }
        render_success("ユーザーの作成に成功しました")
    end

    def update
    end

end