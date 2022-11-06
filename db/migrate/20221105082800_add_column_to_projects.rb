class AddColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :creator, :integer
  end
end
