class AddColumnToJobOutputs < ActiveRecord::Migration
  def change
    add_column :job_outputs, :parentjob_widgetid, :string
  end
end
