class CreateCodeshipProjects < ActiveRecord::Migration
  def change
    create_table :codeship_projects do |t|
      t.integer :codeship_project_uid, index: true
      t.string :repository_name

      t.timestamps
    end
  end
end
