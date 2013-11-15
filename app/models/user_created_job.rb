class UserCreatedJob < ActiveRecord::Base
  
  serialize :output_ids
  serialize :input_ids
  serialize :work_obj, WorkItemComponent
  serialize :jobContents
  serialize :notifications
  
  attr_accessible :didexecute, :input_ids, :job_id, :jobcontents, :jobname, :notifications, :output_ids, :status, :user_id, :work_obj, :summary, :itemid
  
end
