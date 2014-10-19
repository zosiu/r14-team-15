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

  def self.top
    all.sort_by(&:score).reverse.first(4)
  end

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
    case build_ratio
    when 0..25 then 'E'
    when 25..50 then 'D'
    when 50..75 then 'C'
    when 75..90 then 'B'
    else 'A'
    end
  end

  def score
    build_ratio
  end

  def build_ratio
    return 0 if green_builds.count.zero?
    (1 - red_builds.count / green_builds.count.to_f) * 100
  end
end
