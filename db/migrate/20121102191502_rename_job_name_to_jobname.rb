class RenameJobNameToJobname < ActiveRecord::Migration
  def up
    rename_column :jobs, :JobName, :jobname
  end

  def down
  end
end
