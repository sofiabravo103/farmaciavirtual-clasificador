class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def landing
    if current_user and current_user.has_role? :admin
      @users_awaiting_approval = User.where(approved: false)
      @users_awaiting_approval = nil if @users_awaiting_approval == []
      #@approved_users = User.where(approved: true) - User.with_role(:admin)
      #@approved_users = nil if @approved_users == []
    end
  end
end
