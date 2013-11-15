class AddItemidToUserCreatedJobs < ActiveRecord::Migration
  def change
    add_column :user_created_jobs, :itemid, :string
  end
end
