class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def landing
    if current_user and current_user.has_role? :admin
      @users_awaiting_approval = User.where(approved: false)
    end
  end
end
