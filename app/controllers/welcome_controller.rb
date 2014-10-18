class WelcomeController < ApplicationController
  layout false

  def index
    redirect_to admin_root_path if user_signed_in?
  end
end
