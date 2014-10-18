# == Schema Information
#
# Table name: codeship_committers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CodeshipCommitters < ActiveRecord::Base
end
