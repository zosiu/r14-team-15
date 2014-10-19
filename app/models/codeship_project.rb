# == Schema Information
#
# Table name: codeship_projects
#
#  id                   :integer          not null, primary key
#  codeship_project_uid :integer
#  repository_name      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class CodeshipProject < ActiveRecord::Base
  has_many :codeship_project_relations, dependent: :destroy
  has_many :users, through: :codeship_project_relations

  has_many :codeship_builds
  has_many :codeship_committers, -> { distinct }, through: :codeship_builds

  validates :codeship_project_uid, presence: true, uniqueness: true
  validates :repository_name, presence: true

  def green_builds
    codeship_builds.green
  end

  def red_builds
    codeship_builds.red
  end

  def developers
    codeship_committers
  end

  def grade
    'A'
  end

  def score
    100
  end
end
