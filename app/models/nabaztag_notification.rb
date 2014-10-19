# == Schema Information
#
# Table name: nabaztag_notifications
#
#  id           :integer          not null, primary key
#  nabaztag_uid :string(255)
#  message      :string(255)
#  locale       :string(255)      default("en")
#  created_at   :datetime
#  updated_at   :datetime
#

class NabaztagNotification < ActiveRecord::Base
  validates :nabaztag_uid, :message, :locale, presence: true

  def self.for_bunny(uid)
    where(nabaztag_uid: uid).order(updated_at: :asc).take
  end
end
