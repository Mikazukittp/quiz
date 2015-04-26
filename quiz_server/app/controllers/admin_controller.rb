class AdminController < ApplicationController

    # ユーザがログインしていないと"show"にアクセスできない
    before_action :authenticate_admin_user!, except: :index

    def index
    end

end
