class AdminController < ApplicationController

    # ユーザがログインしていないと"show"にアクセスできない
    before_action :authenticate_admin_user!, except: :index

end
