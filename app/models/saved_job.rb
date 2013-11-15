class SavedJob < ActiveRecord::Base
  # attr_accessible :title, :body
  serialize :workflowobjects
  serialize :connections
end
