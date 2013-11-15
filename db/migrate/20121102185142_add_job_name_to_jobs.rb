class AddJobNameToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :JobName, :string
  end
end
