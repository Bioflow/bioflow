class RenameJobContentsToJobContents < ActiveRecord::Migration
  def up
    rename_column :jobs, :JobContents, :jobContents
  end

  def down
  end
end
