class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    if current_user and current_user.has_role? :admin
      @users_awaiting_approval = User.where(approved: false)
      @users_awaiting_approval = nil if @users_awaiting_approval == []
    end
  end

  def project
  end

  def instructions
  end
end
