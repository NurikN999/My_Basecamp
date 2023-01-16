class AddProjectIdToAttachments < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :project_id, :integer
  end
end
