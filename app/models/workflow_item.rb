class WorkflowItem < ActiveRecord::Base
  serialize :inputs
  serialize :outputs
  serialize :formparams
  
  attr_accessible :category, :isparent, :itemid, :name, :parent, :summary, :totalinputs, :totaloutputs, :inputs, :outputs, :commandline, :formparams, :command_format
end
