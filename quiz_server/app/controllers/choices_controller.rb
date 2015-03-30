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
        render :status => 200,
           :json => { :success => true,
                      :info => "選択肢の削除に成功しました",
                      }
      else
        render :status => 401,
           :json => { :success => false,
                      :info => "選択肢の削除に失敗しました",
                      }
      end
    end

    def is_correct
      if choice = Choice.find_by_id(params[:id])
        render :status => 200,　
          :json => { :is_correct => Choice.find_by_id(params[:id]).correct_flag}
      else
        render :status => 401,　:json => { :info => "存在しない選択肢です"}
      end
    end
end
