class JobOutput < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :work_output, :job, :job_id, :widget_id
  
  belongs_to :job
  serialize  :work_output, JobOutputMarker
end
