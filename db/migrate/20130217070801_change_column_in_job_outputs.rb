class ChangeColumnInJobOutputs < ActiveRecord::Migration
  def up
    change_column :job_outputs, :work_output, :text, :limit => nil

  end

  def down
  end
end
