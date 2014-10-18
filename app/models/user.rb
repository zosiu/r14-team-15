# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  codeship_api_token     :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'codeship'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :codeship_api_token, presence: true

  has_many :codeship_project_relations, dependent: :destroy
  has_many :codeship_projects, through: :codeship_project_relations

  after_create :fetch_codeship_projects

  private

  def fetch_codeship_projects
    Codeship.new(codeship_api_token).projects.each do |project|
      p = CodeshipProject.where(codeship_project_uid: project['id'],
                                repository_name: project['repository_name'])
                        .first_or_create!
      CodeshipProjectRelation.where(user: self, codeship_project: p).first_or_create!



    end
  end

end
