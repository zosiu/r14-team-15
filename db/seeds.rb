require 'faker'

user = User.where(email: 'try.me@coding-romeo.com').first_or_create! do |u|
  u.codeship_api_token = 'somecodeshipapitoken'
  u.password = u.password_confirmation = '12345678'
end

projects = []
8.times do |n|
  uid = 52628 + n
  repo = "#{Faker::App.name.downcase}/#{Faker::App.name.downcase}"
  p = CodeshipProject.create codeship_project_uid: uid,
                             repository_name: repo
  projects << p
  CodeshipProjectRelation.create user: user, codeship_project: p
end

developers = []
(projects.count*(projects.count+1)/2).times do
  developers << CodeshipCommitter.create(name: Faker::Internet.user_name(nil, ['-', '_']))
end

90.times do |n|
  projects.each_with_index do |repo, i|
    low = (i)*(i+1) / 2
    high = low + i
    devs = developers[low...high]

    build_uid = Faker::Number.number(i+2)
    developer = devs.sample || developers.first
    status = (['testing', 'stopped', 'waiting'] + ['error']*5 + ['success']*20).sample
    build_url = "https://www.codeship.io/projects/#{repo.codeship_project_uid}/builds/#{build_uid}"
    long_sha = Faker::Internet.password(40).downcase
    commit_url = "https://github.com/#{repo.repository_name}/commit/#{long_sha}"
    short_sha = long_sha[0..6]
    branch = "task_#{build_uid}"
    message = Faker::Lorem.sentence 3, true, 4
    created = Faker::Time.between(20.days.ago, Time.now)

    CodeshipBuild.create build_url: build_url,
                         codeship_build_uid: build_uid,
                         commit_url: commit_url,
                         codeship_project: repo,
                         codeship_committer: developer,
                         status: status,
                         commit_sha: long_sha,
                         short_commit_sha: short_sha,
                         message: message,
                         branch: branch,
                         created_at: created,
                         updated_at: Faker::Time.between(created, Time.now)
  end
end

10.times do |n|
  projects.shuffle.each_with_index do |repo, i|
    [1,2,3].sample.times do
      low = (i)*(i+1) / 2
      high = low + i
      devs = developers[low...high]

      build_uid = Faker::Number.number(i+2)
      developer = devs.sample || developers.first
      status = (['testing', 'stopped', 'waiting'] + ['error']*5 + ['success']*20).sample
      build_url = "https://www.codeship.io/projects/#{repo.codeship_project_uid}/builds/#{build_uid}"
      long_sha = Faker::Internet.password(40).downcase
      commit_url = "https://github.com/#{repo.repository_name}/commit/#{long_sha}"
      short_sha = long_sha[0..6]
      branch = "task_#{build_uid}"
      message = Faker::Lorem.sentence 3, true, 4
      created = Faker::Time.between(20.days.ago, Time.now)

      CodeshipBuild.create build_url: build_url,
                           codeship_build_uid: build_uid,
                           commit_url: commit_url,
                           codeship_project: repo,
                           codeship_committer: developer,
                           status: status,
                           commit_sha: long_sha,
                           short_commit_sha: short_sha,
                           message: message,
                           branch: branch,
                           created_at: created,
                           updated_at: Faker::Time.between(created, Time.now)
    end
  end
end
