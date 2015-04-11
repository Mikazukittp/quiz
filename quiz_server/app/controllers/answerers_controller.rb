class AnswerersController < ApplicationController
    def create
        answerer = Answerer.create(event_id:params[:event_id],name: params[:name])
        #ユーザートークンの発行
        user_token = SecureRandom.uuid
        answerer.update_attributes(:user_token => user_token)
        set_user_token_cookie(user_token)
        render_success("ユーザーの作成に成功しました")
    end

    def update
    end

    def show
        if ck = cookies[:quiz_user_token]
            user = Answerer.find_by(user_token: ck)
            render :json => user
        else
            render_fault("解答者の取得に失敗しました")
        end
    end

    def get_question
        if ck = cookies[:quiz_user_token]
            user = Answerer.find_by(user_token: ck)
            render :json => user.event.questions.find_by(is_current: true)
        else
            render_fault("問題の取得に失敗しました")
        end
    end

    def set_user_token_cookie(user_token)
        cookies[:quiz_user_token] = { :value => user_token, :expires => 1.days.from_now}
    end

    def is_exist_answerer?

    end
end