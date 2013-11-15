class RenameJobcontentsToJobContents < ActiveRecord::Migration
  def up
    rename_column :user_created_jobs, :jobcontents, :jobContents
  end

  def down
  end
end
