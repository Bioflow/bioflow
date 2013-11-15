class AddNotificationsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :notifications, :string
  end
end
