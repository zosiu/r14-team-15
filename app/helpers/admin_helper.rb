module AdminHelper
  def builds_action?
    action?('builds', 'green_builds', 'red_builds')
  end

  def project_build_action?(project)
    action?('project_builds') && codeship_project == project
  end

  def build_fa_class(build)
    case build.status
    when 'error' then 'fa-thumbs-down'
    when 'success' then 'fa-thumbs-up'
    when 'testing', 'waiting' then 'fa-spinner'
    else 'fa-close'
    end
  end

  def build_timeline_class(build)
    case build.status
    when 'error' then 'danger'
    when 'success' then 'success'
    end
  end

  def developer_link(developer)
    link_to developer.name, admin_developer_builds_path(developer.name)
  end

  def project_link(project)
    link_to project.repository_name,
            admin_project_builds_path(project.repository_name)
  end

  def build_link(build)
    link_to build.message, build.build_url
  end

  def build_commit_link(build)
    link_to build.short_commit_sha, build.commit_url
  end

  def developer_codeship_builds(developer)
    codeship_builds.where codeship_committer: developer
  end

  def developer_codeship_projects(developer)
    codeship_builds.where id: developer.codeship_projects.pluck(:id)
  end

  def config_url(url)
    haml_tag :input, class: 'config-url', readonly: 'readonly', type: 'text',
              value: url, onclick: 'this.select();'
  end
end
