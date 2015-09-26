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
      question = Question.includes(:choices).find_by(id: params[:id])
      if question !=nil && check_admin_has_question(question)
        render :json => {:question => question,
                         :choices => question.choices
                         }
      else
        render_fault("存在しないquestionです")
      end
    end

    def create
      attr = params.require(:question).permit(:sentence,
            :points,:question_type_id)

      event = current_admin_user.events.find(params[:question][:event_id])

      question = event.questions.new(attr)

      Question.transaction do
        question.question_number = event.questions.order('question_number').last.question_number + 1
        question.save!

        params[:choices].each do |choice|
          question.choices.create!(choice[1])
        end
      end

      render :json => { :success => true,
                        :info => "質問の作成に成功しました",
                        :question => question,
                        :choices => question.choices
                      }
    end

    def update
      attr = params.require(:question).permit(:event_id,:sentence,:points,:question_type_id)

      question = current_admin_user.questions.find(params[:id])

      Question.transaction do
        question.update!(attr)
        params[:choices].each do |choices|
          choice = question.choices.find(choices[1][:id])
          choice.update!(choices[1])
        end
      end

      event = current_admin_user.events.find(question.event_id)
      order_questions(event.questions)
      render :json => { :success => true,
                        :info => "質問の更新に成功しました",
                        :question => question,
                        :choices => question.choices
                      }
    end

    def destroy
      question = current_admin_user.questions.find(params[:id])
      question.update_attributes(:is_delete => true )
      event = current_admin_user.events.find(question.event_id)
      order_questions(event.questions)
      render_success("質問の削除に成功しました")
    end

    def start
      question = current_admin_user.questions.find(params[:id])
      question.update(status: "accepted")
      render :json => { :success => true,
                        :question => question,
                        :choices => question.choices
                      }
    end

    def end
      question = current_admin_user.questions.find(params[:id])
      question.update(status: "ended")
      render :json => { :success => true,
                        :question => question,
                        :choices => question.choices
                      }
    end


    private

    def check_admin_has_event(event)
      event.admin_user_id === current_admin_user.id
    end

    def check_admin_has_question(question)
      question.event.admin_user_id === current_admin_user.id
    end

    def order_questions(questions)
      questions.order(:question_number).each.with_index(1) do |question,index|
        question.update(question_number: index)
      end
    end
end
