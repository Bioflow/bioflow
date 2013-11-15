class WorkflowItemOutput
  
  
  attr_accessor :output_type, :output_parameter_name, :output_file_name, :output_identifier, :output_parameter_label
  
  def initialize()
    
    #bam file, sam file, sorted, indexed, stuff
    @output_type = ""
    
    # to be passed with executable
    # samtools -output = bamfile
    @output_parameter_name = ""
    
    
    
    @output_file_name = ""
  end
  
  

end
  