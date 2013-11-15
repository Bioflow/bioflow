class AddDidexecuteToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :didexecute, :boolean
  end
end
