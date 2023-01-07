class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :path
    end
  end
end
