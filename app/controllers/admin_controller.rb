class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def projects
  end

  def developers
  end

  def builds
  end

  def red_builds
  end

  def green_builds
  end

  def project_builds
  end

  def developer_builds
  end

  protected

  def codeship_developer
    codeship_committers.find_by_name params[:developer]
  end
  helper_method :codeship_developer

  def top_developers
    codeship_committers.top
  end
  helper_method :top_developers

  def top_projects
    codeship_projects.top
  end
  helper_method :top_projects

  def codeship_developer_builds
    codeship_builds.where codeship_committer: codeship_developer
  end
  helper_method :codeship_developer_builds

  def codeship_project
    @project ||= current_user.codeship_projects.find_by_repository_name! params[:project]
  end
  helper_method :codeship_project

  def codeship_projects
    @codeship_projects ||= current_user.codeship_projects
  end
  helper_method :codeship_projects

  def codeship_committers
    @codeship_committers ||= current_user.codeship_committers
  end
  helper_method :codeship_committers

  def codeship_builds
    @codeship_builds ||= current_user.codeship_builds
  end
  helper_method :codeship_builds
end
