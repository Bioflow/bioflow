class CreateSavedJobs < ActiveRecord::Migration
  def change
    create_table :saved_jobs do |t|

      t.timestamps
    end
  end
end
