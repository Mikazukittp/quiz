class EventsController < ApplicationController
  before_action :check_admin_user_exist, except: :show_with_token

    def index
        events = Event.where(admin_user_id: current_admin_user.id)
        render :json => events
    end

    def show
      event = Event.find_by(id: params[:id])
      if check_admin_has_event(event)
        render :json => event
      else
        render_fault("存在しないeventです。")
      end
    end

    def create
       attr = params.require(:event).permit(:name,:event_date,
            :limit_date,:time_limit,:course_id,:description)
       event = Event.new(attr)
       event.admin_user_id = current_admin_user.id
       event.url = ""
       event.save!
       render :json => { :success => true,
                          :info => "イベントの作成に成功しました",
                          :event => event
       }


    end

    def update
        attr = params.require(:event).permit(:name,:event_date,
            :limit_date,:time_limit,:course_id,:description)
        event = current_admin_user.events.find_by(id: params[:id])
        event.update(attr)
        render :json => { :success => true,
                          :info => "イベントの更新に成功しました",
                          :event => event
       }
    end

    def destroy
      event = Event.find_by(id: params[:id])
      if event != nil && check_admin_has_event(event)
        event.update_attributes(:is_delete => true )
        render_success("イベントの削除に成功しました")
      else
        render_fault("存在しないイベントです")
      end
    end

    def show_with_token
      event = Event.find_by(url_token: params[:url_token])
      return render_fault("存在しないイベントです") if event.nil?
      render :json => event
    end

    def next
      event = Event.find_by(id: params[:id])
      if event != nil && check_admin_has_event(event)
        question = event.questions.find_by(is_current: true)
        if question.nil?
          render :json => { :info => "event is over"}
        else
          question.update_attributes(:is_current => false )
          next_question = event.questions.where("question_number > ?", question.question_number).first
          if next_question.nil?
            render :json => { :is_last => true
                          }
          else
            number = event.questions.where("question_number < ?", next_question.question_number).count + 1
            next_question.update_attributes(:is_current => true )
            render :json => { :question => next_question,
                            :choices => next_question.choices,
                            :number => number
                            }
          end
        end
      else
        render_fault("存在しないイベントです")
      end
    end

    def start
      event = current_admin_user.events
      .includes(:questions).find_by(id: params[:id])
      if event != nil
        return render_fault("有効期限が切れています ") unless check_limit_date(event)
        question = event.questions.order(:question_number).first
        if question != nil
          question.update_attributes(:is_current => true )
          event.update(is_close: false)
          render :json => { :question => question,
                            :choices => question.choices,
                            :number => 1
                          }
        else
          render_fault("質問がまだ作成されていません")
        end
      else
        render_fault("存在しないイベントです")
      end
    end

    def close
      event = current_admin_user.events
      .includes(:answerers, questions: :answers).find_by(id: params[:id])

      return render_fault("存在しないイベントです") if event.nil?

      event.update(is_close: true)
      event.questions.update_all(:is_current => false)

      aggregate_answers(event) #解答者の回答を集計する

      answerers = event.answerers.order(correct_answers: :desc)
      .order(avarage_answer_time: :asc)

      give_rank(answerers)#点数順に並び替えた解答者にランクを付与する

      render :json => answerers
    end

    def clear
        event = current_admin_user.events.find_by(id: params[:id])
        unless event.nil?
          event.answerers.each do |answerer|
            answerer.answers.destroy_all
          end
          event.answerers.destroy_all
          render_success("イベントのclearに成功しました")
        else
          render_fault("存在しないイベントです")
        end
    end

    private

    def check_admin_user_exist
      if current_admin_user == nil
        render_fault("セッションが切れました")
      end
    end

    def check_admin_has_event(event)
      event.admin_user_id === current_admin_user.id
    end

    def aggregate_answers(event)
      event.answerers.each do |answerer|
        points = time = 0

        answerer.answers.each do |answer|
          if is_correct_answer?(answer)
            points += 1
            time += answer.answer_time
          end
        end

        answerer.update(correct_answers: points, avarage_answer_time: points > 0 ? time/points : -1)
      end
    end

    def is_correct_answer?(answer)
      answer.answer_time < 60 && answer.is_correct
    end

    def give_rank(answerers)
      lowest_rank = answerers.where('correct_answers > 0').count + 1
      answerers.each.with_index(1) do |answerer,index|
        if answerer.correct_answers > 0
          answerer.update(rank: index)
        else
          answerer.update(rank: lowest_rank)
        end
      end
    end

    def check_limit_date(event)
      require 'date'
      day = Date.today
      event.limit_date > day
    end

end
