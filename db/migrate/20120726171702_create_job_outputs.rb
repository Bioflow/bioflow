class CreateJobOutputs < ActiveRecord::Migration
  def change
    create_table :job_outputs do |t|
      t.string :work_output
      t.string :job_id
      t.string :widget_id
      
      t.timestamps
    end
  end
end
