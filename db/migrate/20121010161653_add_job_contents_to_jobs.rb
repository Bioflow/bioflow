class AddJobContentsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :JobContents, :string
  end
end
