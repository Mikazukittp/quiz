class EventsController < ApplicationController
    respond_to :json

    def index
        events = Event.find_by(admin_user_id: params[:id])
        render :json => events
    end

    def show
        events = Event.find(params[:id])
        render :json => events
    end

    def create
        attr = params.require(:event).permit(:admin_user_id,:name,:event_date,
            :limit_date,:time_limit,:url,:course_id,:description)

       Event.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "eventの作成に成功しました",
                      }

    end
end
