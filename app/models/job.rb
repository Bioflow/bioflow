class Job < ActiveRecord::Base
  has_many  :jobOutputs
  serialize :output_ids
  serialize :input_ids
  serialize :work_obj, WorkItemComponent
  serialize :jobContents
  serialize :notifications
  attr_accessible :input_ids, :job_id, :output_ids, :work_obj,  :jobContents, :jobOutput, :notifications, :status, :jobname, :didexecute
  
  
  validates :jobname, :uniqueness => true
  belongs_to :user 
end
