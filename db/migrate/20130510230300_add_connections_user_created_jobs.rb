class AddConnectionsUserCreatedJobs < ActiveRecord::Migration
  def change
    add_column :user_created_jobs, :connections, :text, :limit => nil
  end

  def down
  end
end
