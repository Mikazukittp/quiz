class AdminController < ApplicationController
  def index
    redirect_to '/admin_users/sign_in'

  end
end
