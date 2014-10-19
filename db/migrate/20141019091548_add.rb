class Add < ActiveRecord::Migration
  def change
    add_column :users, :codeship_uid, :string, index: true
    User.reset_column_information

    User.find_each(&:save!)
  end
end
