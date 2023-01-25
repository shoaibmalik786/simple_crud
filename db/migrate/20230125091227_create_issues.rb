class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :assign_to
      t.integer :status, default: 0
      t.text :description
      t.integer :project_id

      t.timestamps
    end
  end
end
