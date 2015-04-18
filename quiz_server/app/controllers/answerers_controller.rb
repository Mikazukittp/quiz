class AnswerersController < ApplicationController
    before_filter :get_user_info, :only => [:show, :get_question]

    def index
        event = current_admin_user.events.find_by(id: params[:event_id])
        unless event.nil?
            render :json => event.answerers
        end
    end

    def create
        return render_fault("same name arleady used") if Answerer.exists?(name: params[:name])
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
        unless question.nil?
            render :json => { :question => question,
                              :choices => question.choices }
        else
            render_fault("イベントが開始されておりません")
        end
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