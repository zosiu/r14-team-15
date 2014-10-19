# == Schema Information
#
# Table name: codeship_builds
#
#  id                    :integer          not null, primary key
#  build_url             :string(255)
#  commit_url            :string(255)
#  codeship_project_id   :integer
#  codeship_build_uid    :integer
#  status                :string(255)
#  commit_sha            :string(255)
#  short_commit_sha      :string(255)
#  message               :text
#  branch                :string(255)
#  codeship_committer_id :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class CodeshipBuild < ActiveRecord::Base
  STATUSES = ['testing', 'error', 'success', 'stopped', 'waiting']

  scope :red, -> { where status: 'error' }
  scope :green, -> { where status: 'success' }
  scope :gray, -> { where status: ['testing', 'stopped', 'waiting'] }

  scope :timeline, -> { order(updated_at: :desc).limit 8 }

  belongs_to :codeship_project
  belongs_to :codeship_committer

  validates :codeship_committer_id, :codeship_project_id,
            :codeship_build_uid, :status, :commit_sha,
            :short_commit_sha, :branch, :message, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :codeship_build_uid, uniqueness: true
end
