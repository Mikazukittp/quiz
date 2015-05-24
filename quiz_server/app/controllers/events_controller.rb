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
      h = get_hash_user_rank(event)
      arr = rank_sort(h.to_a)
      add_name_and_rank(arr,event)
      event.questions.update_all(:is_current => false)
      event.update(is_close: true)
      render :json => arr
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

    def set_url
        event = Event.find_by(id: params[:id])
        return render_fault("存在しないイベントです") if event.nil?
        event.set_url
        render :json => event
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

    def get_hash_user_rank(event)
      h = Hash.new
      event.questions.each do |question|
        question.answers.each do |answer|
          unless answer.nil?
            correct = get_point_answer(answer)
            if h.has_key?(answer.answerer_id)
              time = h[answer.answerer_id][0] + answer.answer_time
              correct += h[answer.answerer_id][1]
              h[answer.answerer_id] = [time,correct]
            else
              h[answer.answerer_id] = [answer.answer_time,correct]
            end
          end
        end
      end
      return h
    end

    def rank_sort(arr)
      arr.sort! do |a,b|
        (b[1][1] <=> a[1][1]).nonzero? || (a[1][0] <=> b[1][0])
      end
    end

    def get_point_answer(answer)
      if answer.answer_time < 60 && answer.is_correct
          correct = 1
      else
          correct = 0
      end
    end

    def add_name_and_rank(arr,event)
      arr.each.with_index(1) do |arr , rank|
        answerer = event.answerers.find_by(id: arr[0])
        answerer.update(rank: rank, total_times_answer_correctly: arr[1][0], total_answer_time: arr[1][1])
        arr[0] = answerer.name
        arr.unshift(rank)
      end
    end

    def check_limit_date(event)
      require 'date'
      day = Date.today
      event.event_date > day
    end

    def event_is_exist?
      Event.find_by(id: params[:id]).exist?
    end
end
