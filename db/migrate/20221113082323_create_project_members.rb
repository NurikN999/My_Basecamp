class CreateProjectMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :project_members do |t|
      t.integer :project_id
      t.integer :member_id
      t.integer :role
    end
  end
end
