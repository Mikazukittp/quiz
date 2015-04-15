class QuestionsController < ApplicationController

    def index
      event = Event.find_by(id: params[:event_id])
      if event != nil && check_admin_has_event(event)
        render :json => event.questions
      else
        render_fault("存在しないeventです")
      end
    end

    def show
      question = Question.find_by(id: params[:id])
      if question !=nil && check_admin_has_question(question)
        render :json => question
      else
        render_fault("存在しないquestionです")
      end
    end

    def create
       attr = params.require(:question).permit(:sentence,
            :points,:type_id)

       event = Event.find_by(id: params[:question][:event_id])
       if event != nil && check_admin_has_event(event)
         question = event.questions.create(attr)
         question.update_attributes(:question_number => (event.questions.order('question_number').last.question_number + 1) )
         params[:choices].each do |choice|
            question.choices.create(choice[1])
         end
         render_success("質問の作成に成功しました")
       else
        render_fault("存在しないquestionです")
       end
    end

    def update
       attr = params.require(:question).permit(:event_id,:sentence,
            :points,:type_id)

       question = Question.find(params[:id])
       if question !=nil && check_admin_has_question(question)
         question.update(attr)
         params[:choices].each do |choices|
           choice = question.choices.find_by(id: choices[1][:id])
           if choice != nil
             choice.update(choices[1])
           else
             render_fault("存在しないchoicesです")
             return
           end
         end
         render_success("質問の作成に成功しました")
       else
         render_fault("存在しないquestionです")
       end
    end

    def destroy
      question = Question.find_by(id: params[:id])
      if question != nil && check_admin_has_question(question)
        question.update_attributes(:is_delete => true )
        render_success("質問の削除に成功しました")
      else
        render_fault("存在しないquestionです")
      end
    end

    private

    def check_admin_has_event(event)
      event.admin_user_id === current_admin_user.id
    end

    def check_admin_has_question(question)
      question.event.admin_user_id === current_admin_user.id
    end
end
