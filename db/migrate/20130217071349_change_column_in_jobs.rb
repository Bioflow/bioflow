class ChangeColumnInJobs < ActiveRecord::Migration
  def up
    change_column :jobs, :jobContents, :text, :limit => nil
    change_column :jobs, :notifications, :text, :limit => nil
    change_column :saved_jobs, :workflowobjects, :text, :limit => nil
    change_column :saved_jobs, :connections, :text, :limit => nil
    change_column :user_created_jobs, :jobContents, :text, :limit => nil
    change_column :user_created_jobs, :notifications, :text, :limit => nil
    change_column :workflow_items, :outputs, :text, :limit => nil
    change_column :workflow_items, :inputs, :text, :limit => nil
    
  end

  def down
  end
end
