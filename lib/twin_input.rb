require 'twin_input_output'

class TwinInput < WorkItemComponent
  
  attr_accessor  :STATUS, :SIMULATEDSTATUS, :pretty_name
  
  
  def initialize
    @pretty_name = "Twin Inputs"
  end
  
  def run
  
    start_time = Time.now
    
    JobManager.add_notification(@job_id, "Running TwinInput. Started at "+start_time.to_s)
    
    
    
    puts "********"
    puts "Twin Input Running"
    puts "********"
    
    puts "RUNNING TWININPUT"
    puts "++ ++ ++ ++ ++ "

    @STATUS = "COMPLETE"
    @SIMULATEDSTATUS= "PENDING"

    twininput_output_object = create_output_object()

    store_output_in_database()
    
    
    
    end_time = Time.now
    
    time_taken = start_time - end_time
    
    total_time = time_diff_in_minutes(start_time, end_time)
    
    
    JobManager.add_notification(@job_id, "Finished running TwinOutput at "+end_time.to_s+". Total time taken="+total_time.to_s)

  end

  def create_output_object
    return TwinInputOutput.new

  end

  def store_output_in_database

    job_output_row = JobOutput.where("job_id = ? AND widget_id = ?", @job_id.split('_')[-1] , @widget_db_key )

    job_output = job_output_row.first.work_output

    job_output.output1 = ("First line of output")
    job_output.output1 = ("First line of output")


    job_output_row.first.save

  end

  def set_inputs(inputs_for_job)
    puts "write code to add input"
    puts "the input being set =="+inputs_for_job.inspect
  end

  def set_jobId(job_id)
    puts "SETTING JOB ID AS - TWININPUT "

    @job_id = job_id
    puts @job_id

  end

  def set_widgetId(widget_id)
    
    
    split_widgetid = widget_id.split('_')
    puts split_widgetid
    
    @widget_db_key = split_widgetid[-1]
    
    

  end

  def get_outputs
    puts "GET OUTPUTS CALLED IN TWININPUT CLASS"
  end
  
  
  
   def get_output_as_html(twininput_output)
    
    
   html_str =   "<table style=\"border:3px solid blue\">" \
                     + "<tr>"   \
                     +    "<td style=\"border:3px solid blue\">" \
                     +        "Input file "   \
                     +    "</td>"   \
                     +    "<td>"   \
                     +        twininput_output.output1   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td style=\"border:3px solid blue\">" \
                     +        "Output file "   \
                     +    "</td>"   \
                     +    "<td>"   \
                     +       twininput_output.output2   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     +  "<tr>"   \
                     + "</table>"   
        return html_str
    
  end
  
  
  
  def get_outputs
      
      outputs = Array.new
      some_bamfile = BamFileIo.new
      some_bamfile.is_output=(true)
      some_bamfile.is_sorted=(true)
      some_bamfile.bam_file_name=("Some_Fake_Name")
      outputs << some_bamfile 
      
      
      puts "output being set is "
      puts outputs.inspect
      
      return outputs
      
      
    end
  
  def validate
      
      error = nil
      return error
      
  end
  

end