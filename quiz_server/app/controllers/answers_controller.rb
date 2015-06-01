class AnswersController < ApplicationController
    before_action :check_user_token

    def index
        answers = Answer.where(answerer_id: @user.id)
        render :json => answers
    end

    def show
        answer = Answer.where(id: params[:id],answerer_id: @user.id)
        render :json => answer
    end

    def update
    end

    def create
        return render_fault("一度しか回答できません") if answer_exists?(params[:answer][:question_id])
        attr = params.require(:answer).permit(:question_id,:choice_question_number)
        question = Question.find(params[:answer][:question_id])
        return render_fault("回答は受付中ではありません") unless question.status == "accepted"

        answer = Answer.new(attr)
        answer.answerer_id = @user.id
        answer.answer_time = get_answer_time(question)
        answer.is_correct = is_correct?(question,params[:answer][:choice_question_number])
        answer.save!

        render :json => answer
    end

    private

    def answer_exists?(question_id)
        Answer.find_by(answerer_id:@user.id,question_id:question_id)
    end

    def check_user_token
        unless @user = Answerer.check(cookies[:quiz_user_token])
            render_fault("セッションが切れました")
        end
    end

    def get_answer_time(question)
        updated_at = question.updated_at
        Time.zone.now  - updated_at
    end

    def is_correct?(question,choice_question_number)
        choosen = question.choices.find_by(choice_number: choice_question_number)
        if choosen == nil
            return false
        end
        choosen.correct_flag
    end



end