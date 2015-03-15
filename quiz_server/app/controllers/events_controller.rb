class EventsController < ApplicationController
    respond_to :json

    def index
        events = Event.where(admin_user_id: params[:id],is_delete: false)
        p events
        render :json => events
    end

    def show
        events = Event.find_by(id: params[:id],is_delete: false)
        render :json => events
    end

    def create
    p params[:event]

        attr = params.require(:event).permit(:admin_user_id,:name,:event_date,
            :limit_date,:time_limit,:url,:course_id,:description)

       Event.create(attr)

       render :status => 200,
           :json => { :success => true,
                      :info => "eventの作成に成功しました",
                      }

    end

    def delete
      event = Event.find(params[:id])
      if event.admin_user_id === current_admin_user.id
        event.update_attributes(:is_delete => true )
        render :status => 200,
           :json => { :success => true,
                      :info => "イベントの削除に成功しました",
                      }
      else
        render :status => 401,
           :json => { :success => false,
                      :info => "イベントの削除に失敗しました",
                      }
      end
    end
end
