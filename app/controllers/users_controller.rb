class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user and current_user.has_role? :admin
      user = User.find(params[:id])
      user.approved = true
      user.save!
    end
    redirect_to :root
  end
end
