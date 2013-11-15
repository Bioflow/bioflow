class JobContent 


  attr_accessor :connections, :workflowObjects
  
  def initialize(workflowObjects, connections) 
    
    @workflowObjects  = workflowObjects
    @connections      = connections
    
   end
  
  
  
end