class CreateNabaztagNotifications < ActiveRecord::Migration
  def change
    create_table :nabaztag_notifications do |t|
      t.string :nabaztag_uid, index: true
      t.string :message
      t.string :locale, default: 'en'

      t.timestamps
    end
  end
end
