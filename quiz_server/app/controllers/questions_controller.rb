class QuestionsController < ApplicationController

    def list
        questions = Question
        .where(event_id: params[:id],is_delete: false)
        render :json => questions
    end

    def show
        questions = Question
        .find_by(id: params[:id],is_delete: false)
        render :json => questions
    end

    def create
       attr = params.require(:question).permit(:event_id,:quesion_number,:sentence,
            :points,:type_id)

       question = Question.create(attr)

       attr = params.require(:choice).permit(:sentence,:correct_flag,
            :choice_number,:answered_times)

       question.choices.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "questionの作成に成功しました",
                      }
    end

    def delete
      question = Question.find(params[:id])

      if question.event.admin_user_id === current_admin_user.id
        question.update_attributes(:is_delete => true )
        render :status => 200,
           :json => { :success => true,
                      :info => "問題の削除に成功しました",
                      }
      else
        render :status => 401,
           :json => { :success => false,
                      :info => "問題の削除に失敗しました",
                      }
      end
    end
end
