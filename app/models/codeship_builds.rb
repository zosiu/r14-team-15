# == Schema Information
#
# Table name: codeship_builds
#
#  id                    :integer          not null, primary key
#  build_url             :string(255)
#  commit_url            :string(255)
#  codeship_project_id   :integer
#  status                :string(255)
#  commit_sha            :string(255)
#  short_commit_sha      :string(255)
#  message               :text
#  branch                :string(255)
#  codeship_committer_id :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class CodeshipBuilds < ActiveRecord::Base
  STATUSES = ['testing', 'error', 'success', 'stopped', 'waiting']

  belongs_to :codeship_project
  belongs_to :codeship_committer

  validates :codeship_committer_id, :codeship_build_id, :status, :commit_sha,
            :short_commit_sha, :branch, :message, presence: true
  validates :status, inclusion: { in: STATUSES }
end
