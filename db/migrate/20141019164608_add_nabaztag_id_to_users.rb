class AddNabaztagIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nabaztag_uid, :string, index: true
  end
end
