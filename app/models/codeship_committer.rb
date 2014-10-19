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
    case build_ratio
    when 0..25 then 'E'
    when 25..50 then 'D'
    when 50..75 then 'C'
    when 75..90 then 'B'
    else 'A'
    end
  end

  def score_multiplier
    case codeship_builds.where(status: ['success', 'error']).count
    when 0..70 then 1
    when 70..150 then 2
    when 150..500 then 3
    when 500..1000 then 4
    when 1000..5000 then 5
    else 6
    end
  end

  def score
    build_ratio * score_multiplier
  end

  def build_ratio
    return 0 if green_builds.count.zero?
    (1 - red_builds.count / green_builds.count.to_f) * 100
  end
end
