class QuesionsController < ApplicationController

    def list
        questions = Question.where(event_id: params[:id])
        render :json => questions
    end

    def show
        questions = Question.find(params[:id])
        render :json => questions
    end

    def create
        attr = params.require(:event).permit(:admin_user_id,:name,:event_date,
            :limit_date,:time_limit,:url,:course_id,:description)

       Question.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "questionの作成に成功しました",
                      }
        end
end
