# == Schema Information
#
# Table name: codeship_committers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CodeshipCommitter < ActiveRecord::Base
  has_many :codeship_builds
  has_many :codeship_projects, -> { distinct }, through: :codeship_builds

  def self.top
    all.sort_by(&:score).reverse.first(4)
  end

  def green_builds
    codeship_builds.green
  end

  def red_builds
    codeship_builds.red
  end

  def projects
    codeship_projects
  end

  def grade
    'A'
  end

  def score
    100
  end
end
