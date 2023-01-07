class AddColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :creator, :integer
    add_column :projects, :attachment_id, :integer
  end
end
