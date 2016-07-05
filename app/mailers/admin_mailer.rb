class AdminMailer < ApplicationMailer
  def new_user_waiting_for_approval(user)
    @user = user
    unless User.with_role(:admin) == []
      mail(to: User.with_role(:admin).first.email, subject: 'New user waiting for approval')
    end
  end
end
