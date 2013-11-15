class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_id
      t.string :work_obj
      t.string :input_ids
      t.string :output_ids

      t.timestamps
    end
  end
end
