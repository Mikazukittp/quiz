class CoursesController < ApplicationController
    def index
        render :json => Course.all
    end

    def show
        render :json => Course.find_by(id: params[:id])
    end
end