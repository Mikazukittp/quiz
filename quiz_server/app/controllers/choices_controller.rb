class ChoicesController < ApplicationController

    def list
        choices = Choice
        .where(question_id: params[:id],is_delete: false)
        render :json => choices
    end

    def show
        choices = Choice
        .find_by(id: params[:id],is_delete: false)
        render :json => choices
    end


    def delete
      choice = Choice.find_by_id(params[:id])

      if choice.question.event.admin_user_id === current_admin_user.id
        choice.update_attributes(:is_delete => true )
        rendre_success("選択肢の削除に成功しました")
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
end
