class BamFile < WorkItemComponent
  
  attr_accessor :baseDir, :bamFile, :STATUS, :SIMULATEDSTATUS, :pretty_name
  
  def baseDirForBams
    @baseDir = BAM_BASE_DIR['bam_base_dir']
    ap @baseDir
    
    @pretty_name = "Bam File"
  end

  def initialize(bamFileName)
    baseDirForBams()
    @bamFile = ""
    @STATUS  = "PENDING"
    @SIMULATEDSTATUS= "PENDING"
  end

  def getFullPathToFile()
    return @baseDir + "/" + @bamFile
  end
  
  def bamFileName=(bam_file_name)  
    @bamFile = bam_file_name  
  end 
  
  def run
    
    @STATUS = "RUNNING"
    puts "********"
    puts "Bam File RUNNING"
    puts "********"
    
    @STATUS = "COMPLETE"
    
  end
  
  
  def set_inputs(inputs_for_job)
    puts "write code to add input"
  end
  
  
  def get_outputs
    #output_bam_file = BamFileIo.new
    #output_bam_file.is_output=(true)
    #output_bam_file.bam_file_name=(@bamFile)
    
    #outputs = Array.new
    #outputs << output_bam_file
    
    
    
    output_bam_file = WorkflowItemOutput.new
    output_bam_file.output_type="bamFile"
    output_bam_file.output_file_name=(@bamFile)
    
    outputs = Array.new
    outputs << output_bam_file
    
    
    
    return outputs
  end
  
  
  
  def set_jobId(job_id) 
    puts "SETTING JOB ID AS - BamFile "
    
    @job_id = job_id
    puts @job_id
    
  end
  
  
  def set_widgetId(widget_id)
    
    
    puts "SETTING WIDGET KEY ---"
    @widget_id = widget_id
    
    puts @widget_id
    split_widgetid = @widget_id.split('_')
    puts split_widgetid
    
    @widget_db_key = split_widgetid[-1]
    puts @widget_db_key
  end
  
  
  
   def create_command_line 
    
    
    
    puts  "CREATE command line inside BAM FILE"
    puts "I have no command line -- so I create nothing"

    return ""
  end


  def validate
      error = nil
      ap "Validate inside bam file ---------"
      if @bamFile == nil || @bamFile == ''
          error = "Select an input file for Bam File object"
          
      else
        ap "The bam file is "
        ap @bamFile  
      end
        
      
      return error
  end


end