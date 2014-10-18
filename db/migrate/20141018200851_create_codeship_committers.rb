class CreateCodeshipCommitters < ActiveRecord::Migration
  def change
    create_table :codeship_committers do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
