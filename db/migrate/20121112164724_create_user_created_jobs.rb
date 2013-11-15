class CreateUserCreatedJobs < ActiveRecord::Migration
  def change
    create_table :user_created_jobs do |t|
      t.string :job_id
      t.string :work_obj
      t.string :input_ids
      t.string :output_ids
      t.string :jobcontents
      t.string :notifications
      t.string :status
      t.string :jobname
      t.string :user_id
      t.string :didexecute

      t.timestamps
    end
  end
end
