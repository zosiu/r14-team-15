class WelcomeController < ApplicationController
  layout false

  def index
    redirect_to admin_root_path if user_signed_in?
  end

  def guest_login
    user = User.find_by_email 'try.me@coding-romeo.com'
    sign_in user, bypass: true

    redirect_to admin_root_path
  end
end
