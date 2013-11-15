class AddWorkflowitemsUserCreatedJobs < ActiveRecord::Migration
  def change
    add_column :user_created_jobs, :workflow_items, :text, :limit => nil
  end

  def down
  end
end
