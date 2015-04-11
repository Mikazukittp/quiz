class EventsController < ApplicationController
    respond_to :json

    def index
        events = Event.where(admin_user_id: params[:id],is_delete: false)
        p events
        render :json => events
    end

    def show
        events = Event.find_by(id: params[:id],is_delete: false)
        render :json => events
    end

    def create

        attr = params.require(:event).permit(:admin_user_id,:name,:event_date,
            :limit_date,:time_limit,:url,:course_id,:description)

       Event.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "eventの作成に成功しました",
                      }
    end

    def update

        attr = params.require(:event).permit(:admin_user_id,:name,:event_date,
            :limit_date,:time_limit,:url,:course_id,:description)

        Event.update(params[:id],attr)

        render :status => 200,
           :json => { :success => true,
                      :info => "eventの更新に成功しました",
                      }
    end

    def delete
      event = Event.find(params[:id])
      if event.admin_user_id === current_admin_user.id
        event.update_attributes(:is_delete => true )
        render :status => 200,
           :json => { :success => true,
                      :info => "イベントの削除に成功しました",
                      }
      else
        render :status => 401,
           :json => { :success => false,
                      :info => "イベントの削除に失敗しました",
                      }
      end
    end

    def next
      event = Event.find_by(id:params[:id])
      if question = event.questions.find_by(is_current: true)
        question.update_attributes(:is_current => false )
        next_question = event.questions.where("question_number > ?", question.question_number).first
        next_question.update_attributes(:is_current => true )
        render :json => next_question
      else
        question = event.questions.order(:question_number).first
        question.update_attributes(:is_current => true )
        render :json => question
      end
=begin
      if params[:question_number] != nil
        event.questions.find_by(question_number: params[:question_number]).update_attributes(:is_current => false )
        question = event.questions.find_by(question_number: params[:question_number].to_i + 1)
        question.update_attributes(:is_current => true )
        render :json => question
      else
        question = event.questions.where("question_number >= 1").first
        question.update_attributes(:is_current => true )
        render :json => question
      end
=end
    end
end
