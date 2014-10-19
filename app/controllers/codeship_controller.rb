class CodeshipController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token

  def register_builds
    user = User.find_by_codeship_uid! params[:codeship_uid]

    build_attrs = JSON.parse(request.body.read)['build']

    # project
    project_id = build_attrs['project_id']
    project_name = build_attrs['project_full_name']
    project = CodeshipProject.where(codeship_project_uid: project_id,
                                    repository_name: project_name)
                             .first_or_create!

    # developer
    dev_name = build_attrs['committer']
    developer = CodeshipCommitter.where(name: dev_name).first_or_create!

    # build
    build_id = build_attrs['build_id']

    build = CodeshipBuild.find_or_initialize_by codeship_build_uid: build_id
    build.build_url = build_attrs['build_url']
    build.commit_url = build_attrs['commit_url']
    build.codeship_project = project
    build.codeship_committer = developer
    build.status = build_attrs['status']
    build.commit_sha = build_attrs['commit_id']
    build.short_commit_sha = build_attrs['short_commit_id']
    build.message = build_attrs['message']
    build.branch = build_attrs['message']
    build.save!

    # user - project relation
    CodeshipProjectRelation.where(user: user, codeship_project: project).first_or_create!

    render json: {}, status: :ok
  rescue => e
    render json: { error: e.message }, status: 422
  end
end
