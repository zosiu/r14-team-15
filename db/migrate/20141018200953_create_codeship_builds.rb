class CreateCodeshipBuilds < ActiveRecord::Migration
  def change
    create_table :codeship_builds do |t|
      t.string :build_url
      t.string :commit_url
      t.integer :codeship_project_id, index: true
      t.string :status
      t.string :commit_sha
      t.string :short_commit_sha
      t.text :message
      t.string :branch
      t.integer :codeship_committer_id

      t.timestamps
    end
  end
end
