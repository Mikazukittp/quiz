class QuestionsController < ApplicationController

    def list
        questions = Question.where(event_id: params[:id])
        render :json => questions
    end

    def show
        questions = Question.find(params[:id])
        render :json => questions
    end

    def create
        attr = params.require(:question).permit(:event_id,:quesion_number,:sentence,
            :points,:type_id)

       Question.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "questionの作成に成功しました",
                      }
        end
end
