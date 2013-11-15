class AddColumnsToSavedJobs < ActiveRecord::Migration
  def change
    add_column :saved_jobs, :summary, :string
    add_column :saved_jobs, :totalinputs, :integer
    add_column :saved_jobs, :totaloutputs, :integer
    add_column :saved_jobs, :parent, :string
    add_column :saved_jobs, :isparent, :boolean
    add_column :saved_jobs, :itemid, :string
    add_column :saved_jobs, :workflowobjects, :string
    add_column :saved_jobs, :connections, :string
    add_column :saved_jobs, :name, :string
    add_column :saved_jobs, :category, :string
  end
end
