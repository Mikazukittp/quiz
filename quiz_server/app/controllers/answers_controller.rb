class AnswersController < ApplicationController

    def index
        answers = Answer.where(answerer_id: check_user_token.id)
        render :json => answers
    end

    def show
        answer = Answer.where(id: params[:id],answerer_id: check_user_token.id)
        render :json => answer
    end

    def update
    end

    def create
        attr = params.require(:answer).permit(:question_id,:choice_question_number)
        answer = Answer.new(attr)
        answer.answerer_id = check_user_token.id
        question = Question.find_by(id: params[:answer][:question_id])
        answer.answer_time = get_answer_time(question)
        answer.is_correct = is_correct?(question,params[:answer][:choice_question_number])
        answer.save!
        render :json => answer
    end

    private

    def check_user_token
        if ck = cookies[:quiz_user_token]
            user = Answerer.find_by(user_token: ck)
        else
            render_fault("セッションが切れています")
            return
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