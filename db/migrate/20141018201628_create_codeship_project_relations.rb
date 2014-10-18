class CreateCodeshipProjectRelations < ActiveRecord::Migration
  def change
    create_table :codeship_project_relations do |t|
      t.integer :user_id, index: true
      t.integer :codeship_project_id, index: true

      t.timestamps
    end
  end
end
