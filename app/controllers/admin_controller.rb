class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def projects
  end

  protected

  def codeship_projects
    @codeship_projects ||= current_user.codeship_projects
  end
  helper_method :codeship_projects
end
