class AnswerersController < ApplicationController
    before_filter :get_user_info, :only => [:show, :get_question]
    def create
        answerer = Answerer.create(event_id:params[:event_id],name: params[:name])
        #ユーザートークンの発行
        user_token = SecureRandom.uuid
        answerer.update_attributes(:user_token => user_token)
        set_user_token_cookie(user_token)
        render_success("ユーザーの作成に成功しました")
    end

    def show
        render :json => @user
    end

    def get_event
        event = Event.find_by(url_token: params[:url_token])
        if event != nil
            render :json => event
        else
            render_fault("URLが間違っています")
        end
    end

    def get_question
        question = @user.event.questions.includes(:choices).find_by(is_current: true)
        render :json => { :question => question,
                          :choices => question.choices }
    end

    private

    def set_user_token_cookie(user_token)
        cookies[:quiz_user_token] = { :value => user_token, :expires => 1.days.from_now}
    end

    def get_user_info
        unless @user = Answerer.check(cookies[:quiz_user_token])
            render_fault("セッションが切れました")
        end
    end

end