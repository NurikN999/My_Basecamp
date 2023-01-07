class AddAttachmentIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :attachment_id, :integer
  end
end
