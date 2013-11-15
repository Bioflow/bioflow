class JobStatus


  #STATUS values are
  # COMPLETE, RUNNING, ERROR, PENDING

  def initialize
  
    @STATUS = "PENDING"
    
  end

  def self.is_status_teriminal(status)
    if status == "COMPLETE" || status == "ERROR"
      return true
    end
    
    return false
  end
  
  def self.is_status_non_teriminal(status)
    if status == "PENDING" || status == "RUNNING"
      return true
    end
    
    return false
  end
  
  
end