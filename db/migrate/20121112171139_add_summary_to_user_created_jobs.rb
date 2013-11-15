class AddSummaryToUserCreatedJobs < ActiveRecord::Migration
  def change
    add_column :user_created_jobs, :summary, :string
  end
end
