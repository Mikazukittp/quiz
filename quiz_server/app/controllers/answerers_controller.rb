class AnswerersController < ApplicationController
    before_filter :get_user_info, :only => [:show, :get_question]

    def index
        event = current_admin_user.events.find_by(id: params[:event_id])
        unless event.nil?
            render :json => event.answerers
        end
    end

    def create
        event = Event.includes(:answerers).find_by(id:params[:event_id])
        return render_fault("存在しないイベントです") if event.nil?
        return render_fault("既に同じ名前の参加者が存在します") if event.answerers.exists?(name: params[:name])
        answerer = event.answerers.create(name: params[:name])
        #ユーザートークンの発行
        user_token = SecureRandom.uuid
        answerer.update_attributes(:user_token => user_token)
        set_user_token_cookie(user_token)
        render_success("ユーザーの作成に成功しました")
    end

    def show
        render :json => { :user => @user,
                          :answers => @user.answers,
                          :questions => @user.event.questions
                      }
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
        return render_fault("イベントが開始されておりません") if question.nil?
        return render_fault("質問は準備中です") if question.status == "prepared"
        render :json => { :question => question,
                          :choices => question.choices,
                          :is_last => is_last?(question)
                      }
    end

    private

    def is_last?(question)
        !@user.event.questions.where("id > ?",question.id).exists?
    end

    def set_user_token_cookie(user_token)
        cookies[:quiz_user_token] = { :value => user_token, :expires => 7.days.from_now}
    end

    def get_user_info
        unless @user = Answerer.check(cookies[:quiz_user_token])
            render_fault("セッションが切れました")
        end
    end

end