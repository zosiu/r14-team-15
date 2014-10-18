# == Schema Information
#
# Table name: codeship_project_relations
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  codeship_project_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class CodeshipProjectRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :codeship_project

  validates :user_id, :codeship_project_id, presence: true
  validates :codeship_project_id, uniqueness: { scope: :user_id }
end
