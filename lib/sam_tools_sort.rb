require "sam_tools_sort"
 
class SamToolsSort < WorkItemComponent
  
  attr :on, true
  
  attr_accessor :on, :m, :output_file,:input_file, :STATUS, :samtools_sort_output, :SIMULATEDSTATUS, :pretty_name
  def initialize
    @pretty_name = "Samtools Sort"
    @baseDir    =
    @input_file = ""
    @STATUS  = "PENDING"
    @SIMULATEDSTATUS= "PENDING"
    @on=""
    @m = ""
    @output_file=""
    
  end

  def on
    @on
  end

  def m
    @m
  end

  def outputFile
    @output_file
  end

  def sort_on=(sort_on)
    @on   = sort_on
  end

  def sort_mem=(sort_mem)
    @m    = sort_mem
  end

  def sort_outputfile=(sort_outputfile)
    @output_file = sort_outputfile
  end

  def add_input_file(input_file_to_sort)
    @input_file = input_file_to_sort
  end

  def set_inputs(inputs_for_job)

    for input in inputs_for_job
      puts "set_inputs----......."
      puts "set_inputs----......."
      puts inputs_for_job.inspect
      puts "set_inputs----......."
      #puts "set_inputs================="

      if  input.instance_of? BamFileIo
        @baseDir    = BAM_BASE_DIR['bam_base_dir']
        ap "Bam file BASE_DIR is"
        ap BAM_BASE_DIR
        ap @baseDir
        
        
        @input_file = @baseDir + File::SEPARATOR + input.bam_file_name

        
        puts "setting input here"
        puts "=============="
        puts "=============="
        puts @baseDir.inspect
        puts self.inspect
        puts @input_file.inspect
        puts "=============="
        puts "=============="
      else
        puts "Unknown input -- ignoring it. prolly error - check this"
      end
    
    end
  end
  
  
  
  
  
  
  def set_jobId(job_id)
    puts "-----------------------------------"
    puts "-----------------------------------" 
    puts "SETTING JOB ID AS - SamToolsSort"
    puts "-----------------------------------"
    puts "-----------------------------------"
    
    @job_id = job_id
    puts @job_id
    
  end
  
  
  
  
  
  
  def set_widgetId(widget_id)
    
    
    #puts "SETTING WIDGET KEY ---"
    @widget_id = widget_id
    
    #puts @widget_id
    split_widgetid = @widget_id.split('_')
    puts split_widgetid
    
    @widget_db_key = split_widgetid[-1]
   # puts @widget_db_key
  end
  
  
  def create_command_line 
    
    
    
    puts  "CREATE command line inside SAMTOOLSSORT"
    
    command = "samtools sort"
    space = " "
    if   @on != nil and @on != ""
      command = command + space + "-on" + space + @on
    end

    
    
    if  @m != nil and @m != "" 
      command = command + space + "-m" + space + @m
    end
    
    output_file_newname = generate_output_file()

    if @output_file != nil and @output_file != ""  
      command = command + space + @input_file.inspect + " " +@baseDir + File::SEPARATOR + @output_file
    else

      command = command + space + @input_file.inspect + " " + "\"" + @baseDir + File::SEPARATOR + output_file_newname + "\""
      @output_file = output_file_newname
    end
    
     #
     #  Need to change this to create_fake_output_file
     #
     
     
      
     bam_file_output_object = create_output_object(0, "Fake", "FAKE", @output_file)
     
     return command
  end



  def run
    
    
    start_time = Time.now
    
    ap "Running - inside samtools and the job id is"
    ap @job_id
    
    JobManager.add_notification(@job_id, "Running SamTools. Started at "+start_time.to_s)
    
    
    
    
    
    
    @STATUS = "RUNNING"

    puts "********"
    puts "samtools sort"
    puts "********"
    

  
    puts self.inspect

    command = "samtools sort"
    space = " "
    if   @on != nil and @on != ""
      command = command + space + "-on" + space + @on
    end

    if  @m != nil and @m != "" 
      command = command + space + "-m" + space + @m
    end

    output_file_newname = generate_output_file()
    
    if @output_file != nil and @output_file != ""  
      command = command + space + @input_file.inspect + " " +@baseDir + File::SEPARATOR + @output_file
    else

      command = command + space + @input_file.inspect + " " + "\"" + @baseDir + File::SEPARATOR + output_file_newname + "\""
      @output_file = output_file_newname
    end
    
    
    

    puts "The command for running samtools is "
    puts command
    puts "\\\\\\\\\\\\\\\\\\\\\\\\ Next - running job"
    exit_status_job, stdout_job, stderr_job = run_the_job(command)
    puts "\\\\\\\\\\\\\\\\\\\\\\\\ running job - DONE"
    
    
    if exit_status_job.nil?
         #@STATUS = "ERROR"
         @STATUS = "COMPLETE"
    elsif
        if exit_status_job == 0
          @STATUS = "COMPLETE"
        elsif exit_status_job < 0
          #@STATUS = "ERROR"
          @STATUS = "COMPLETE"
        end       
    end
    
    
    bam_file_output_object = create_output_object(exit_status_job, stdout_job, stderr_job,@output_file)
    
    store_output_in_database(exit_status_job, stderr_job, stderr_job)
    
    
    
    puts "Output of samtools sort"+stdout_job
    puts "exit code"+exit_status_job.inspect
    puts "stderr"+stderr_job
    puts "stdout" + stdout_job

    
    
    
    end_time = Time.now
    
    time_taken = start_time - end_time
    
    total_time = time_diff_in_minutes(start_time, end_time)
    
    
    JobManager.add_notification(@job_id, "Finished running SamTools at "+end_time.to_s+". Total time taken="+total_time.to_s)
    
  end
  
  
  
  
  def create_output_object(exit_status, stdout_job, stderr_job, outputfile)
    
    if exit_status == 0
      # successfully executed
      # so create an output object
      
      @sorted_output_bam_file = BamFileIo.new
      @sorted_output_bam_file.is_output=(true)
      @sorted_output_bam_file.is_sorted=(true)
      @sorted_output_bam_file.bam_file_name=(@output_file.to_s+".bam") # samtools adds this .bam
    end
    
  end
  
  
    def get_outputs
      
      outputs = Array.new
      outputs << @sorted_output_bam_file
      
      
      puts "output being set is "
      puts outputs.inspect
      
      return outputs
      
      
    end
  
  def store_output_in_database(exit_status, stdout, stderr)
    
    
    puts "++++++++++++About to update output in database +++++++++++++"
    ap "Update DB with output --   samtools.  And the job id is"
    ap @job_id
    
    
    job_output_row = JobOutput.where("job_id = ? AND widget_id = ?", @job_id.split('_')[-1] , @widget_db_key )
    
    puts "did this work?"
    puts job_output_row.inspect
    # has_many  assoaciation - hence array or whatever
    # There has to be only on entry -- 
    job_output = job_output_row.first.work_output
    
    if stdout.length == 0
      stdout = "-- None -- "
    end
    
    if stderr.length == 0
      stderr = "-- None -- "
    end
    
    job_output.stdout = (stdout)
    job_output.stderr = (stderr)
    job_output.exit_code = (exit_status)
    job_output.input_file_name = @input_file
    job_output.output_file_name = @output_file
    
    
    puts "++++++++++++Saving the following data"
    puts job_output.stdout
    puts job_output.stderr
    puts job_output.exit_code
    job_output.input_file_name = @input_file
    job_output.output_file_name = @output_file

    job_output_row.first.save
        
  end

  def get_output
    puts "THIS IS WRONG WHO IS CLALING THIS METHID"
    return @sam_tools_sort_output
  end

  #TODO : to be implemented
  # coming soon
  def generate_output_file
    return "output_file_"+Time.new.usec.inspect
  end
  
  
  
  def get_output_as_html(samtools_sort_output1)
    puts "GET OUTPUT AS HTML - SAMTOOLS SORT"
    
    puts samtools_sort_output1.inspect
    puts "inside sget output as html - parameter is "
    
    split_input_filename = "testLiL.bam - (needs to be fixed)"
    puts split_input_filename
    #if samtools_sort_output1.work_output.input_file_name != null 
    #  puts "not null"
    #  split_input_filename =  samtools_sort_output1.input_file_name.split("/").last
    #end
    #filename = split_input_filename[split_input_filename.size]
    
    #puts "filename is "
    #puts filename.inspect
    
       html_str =    "<div class=\"output-header\" >" \
                     +  "Sam tools sort"   \
                     +  "</div>" \
                     +    "<table class= \"output-table-style\" >" \
                     + "<tr>"   \
                     +    "<td class=\"output-table-cell-left\">" \
                     +        "Input file "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        split_input_filename   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">" \
                     +        "Output file "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +       samtools_sort_output1.output_file_name   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     +  "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Status "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        "TBD-status"   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Stdout "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        samtools_sort_output1.stdout   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Stderr "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +         samtools_sort_output1.stderr   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td class=\"output-table-cell-left\">"   \
                     +        "exit_code "   \
                     +    "</td>"   \
                     +    "<td>"   \
                     +       samtools_sort_output1.exit_code.to_s \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "</table>"   
                     #.to_s   
        return html_str
    
  end
  
  
  def validate
      error = nil
      
      
        
      
      return error
  end
  
  
  

end