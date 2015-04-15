class EventsController < ApplicationController
  before_action :check_admin_user_exist

    def index
        events = Event.where(admin_user_id: current_admin_user.id)
        render :json => events
    end

    def show
      event = Event.find_by(id: params[:id],is_delete: false)
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
       render_success("イベントの作成に成功しました")

    end

    def update
        attr = params.require(:event).permit(:name,:event_date,
            :limit_date,:time_limit,:course_id,:description)
        event = current_admin_user.events.find_by(id: params[:id])
        event.update(attr)
        render_success("イベントの更新に成功しました")
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

    def next
      event = Event.find_by(id: params[:id])
      if event != nil && check_admin_has_event(event)
        if question = event.questions.find_by(is_current: true)
          question.update_attributes(:is_current => false )
          next_question = event.questions.where("question_number > ?", question.question_number).first
          next_question.update_attributes(:is_current => true )
          render :json => next_question
        else
          question = event.questions.order(:question_number).first
          question.update_attributes(:is_current => true )
          render :json => question
        end
      else
        render_fault("存在しないイベントです")
      end
    end

    def close
      event = current_admin_user.events
      .includes(:answerers, questions: :answers).find_by(id: params[:id])
      h = get_hash_user_rank(event)
      arr = rank_sort(h.to_a)
      add_name_and_rank(arr,event)
      event.questions.update_all(:is_current => false)
      render :json => arr
    end

    private

    def check_admin_user_exist
      if current_admin_user == nil
        render_fault("セッションが切れました")
      end
    end

    def check_admin_has_event(event)
      p event
      event.admin_user_id === current_admin_user.id
    end

    def get_hash_user_rank(event)
      h = Hash.new
      event.questions.each do |question|
        question.answers.each do |answer|
          if answer.is_correct
            flag = 1
            if h.has_key?(answer.answerer_id)
              time = h[answer.answerer_id][0] + answer.answer_time
              flag += h[answer.answerer_id][1]
              h[answer.answerer_id] = [time,flag]
            else
              h[answer.answerer_id] = [answer.answer_time,flag]
            end
          end
        end
      end
      h
    end

    def rank_sort(arr)
      arr.sort! do |a,b|
        (b[1][1] <=> a[1][1]).nonzero? || (a[1][0] <=> b[1][0])
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
end
