class ChoicesController < ApplicationController

    def index
      question = Question.find_by(id: params[:question_id])
      if question != nil && check_admin_has_question(question)
        render :json => question.choices
      else
        render_fault("存在しないquestionです")
      end
    end

    def show
      choice = Choice.find_by(id: params[:id])
      if choice != nil && check_admin_has_choice(choice)
        render :json => choice
      else
        render_fault("存在しないchoiceです")
      end
    end

    def destroy
      choice = Choice.find_by_id(params[:id])
      if choice != nil && check_admin_has_choice(choice)
        choice.update_attributes(:is_delete => true )
        render_success("選択肢の削除に成功しました")
      else
        render_fault("選択肢の削除に失敗しました")
      end
    end

    def is_correct
      if choice = Choice.find_by_id(params[:id])
        render :status => 200,
          :json => { :is_correct => choice.correct_flag}
      else
        render_fault("存在しない選択肢です")
      end
    end

    private

    def check_admin_has_question(question)
      question.event.admin_user_id === current_admin_user.id
    end

    def check_admin_has_choice(choice)
      choice.question.event.admin_user_id === current_admin_user.id
    end
end
