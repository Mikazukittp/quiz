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
       attr = params.require(:question).permit(:sentence,
            :points,:type_id)

       event = Event.find_by(id: params[:question][:event_id])

       question = event.questions.create(attr)
       question.update_attributes(:question_number => (event.questions.order('question_number').last.question_number + 1) )

       params[:choices].each do |choice|
          question.choices.create(choice[1])
       end
       render_success("質問の作成に成功しました")
    end

    def update

       attr = params.require(:question).permit(:event_id,:sentence,
            :points,:type_id)

       question = Question.find(params[:id])
       question.update(attr)


       params[:choices].each do |choice|
          if !question.choices.empty? && choice[1][:id] != ""
            selectedChoice = question.choices.find(choice[1][:id])
            selectedChoice.update(choice[1])
          else
            question.choices.create(choice[1])
          end
       end
       render_success("質問の更新に成功しました")

    end

    def delete
      begin
        question = Question.find_by(id: params[:id])
        if question.event.admin_user_id === current_admin_user.id
          question.update_attributes(:is_delete => true )
          render_success("質問の削除に成功しました")
        else
          render_fault("管理外のquestionです")
        end
      rescue => ex
        ex.message
        render_fault("存在しないquestionです")
      end
    end
end
