class WorkflowItemWorker < WorkItemComponent
  
  
    attr_accessor :name, :outputs, :inputs, :itemid, :commandline, :pretty_name, :STATUS, :SIMULATEDSTATUS, :job_id, :form_params, :category, :widget_id
  
    def initialize(workflow_item_id)
      
      
      
      
      
      workflow_item = WorkflowItem.find_by_itemid(workflow_item_id)
      
      #Need null and error checks
      
      @category    = workflow_item.category 
      @name        = workflow_item.name
      @inputs      = workflow_item.inputs
      @outputs     = workflow_item.outputs
      @itemid      = workflow_item.itemid
      @commandline = workflow_item.commandline
      @commandformat = workflow_item.command_format
      
      @pretty_name = ""
      @STATUS  = "PENDING"
      @SIMULATEDSTATUS= "PENDING"
      
      @form_params = workflow_item.formparams
      
    end
  
  
  
    def set_inputs(inputs_for_job, connections, workflowitem)
      
      
      
      
      #inputs_for_job is of WorkflowItemOutput INSTANCE
      
      
      # If input types match, then assign them
      # Otherwise, just randomly assign them
      
      #Ideally every input and output should have a type ..
      # But this is not an ideal world !!
      
      #NOOOOOO
      
      # Need to keep track of "outputs" produced !!
      # Need to display TOOLTIP on UI saying which output is produced
      # and that should be matched ....
      # THATS second phase .. FIRST, make it work 
      
            ap "Printing inputs here -- clear terminal now.. ya thanks"
            
            
            
            
            
            
            ap "Surce obj is"
            ap workflowitem
            ap "INPUT PARAM"
            ap inputs_for_job
            
            ap "connections are"
            ap connections

            
            ap "------"
            ap "------"
            ap "ERRONEOUS -- SHOULD not create new array"
            ap "Fix after fixing the connections part"
            ap "Inputs are (BEFORE)"
            ap @inputs
            ap "------"
            ap "------"
            ap "------"
            ap "------"
            ap "------"
            ap "------"
            
            
            
            ap "Searching for the right stuff to match and set inputs"
      
      
            output_of_previous_job = inputs_for_job
      
            for prev_output in output_of_previous_job
                
                #Got an input ....
                # It is of type WorkflowItemOUTPUT MAN ... get its ID
                
                prev_output_id = prev_output.output_identifier
                
                # assume it is "input_0"
                
                # Now find the connection connected to that slot....
                
                
                for connection in connections
                    
                          found = false
                    
                          # looping over connections
                    
                          anchor = connection[0].anchor
                          ep_mapping = EndpointIdMapping.new
                          
                          mapping = ep_mapping.get_mapping()
                          
                          ap "mapping is"
                          ap mapping
                          ap "anchor is"
                          ap anchor
                           
                          if mapping[anchor] == prev_output_id && connection[0].id == workflowitem
                                ap "Found the connection!!!"
                                ap "Now lets see what it is"
                                ap anchor + "-anchor is connected to the ID --" + mapping[connection[1].anchor]
                                
                                input_id = mapping[connection[1].anchor]
                                
                                found = true
                                
                                # now find it
                                
                                for a_input in @inputs
                                    if a_input.input_identifier == input_id
                                        # FOUND IT
                                        
                                        ap "Found the input object where the data has to be set"
                                        
                                        filename = prev_output.output_file_name
                                        if File.exists?(filename)
                                          a_input.input_value  = filename
                                        else
                                          a_input.input_value  = filename + ".bam"
                                        end
                                         
                                        
                                    end
                                end
                        
                        end 
                        
                        ap "found value is"
                        ap found
                        
                        if found == true
                        
                          ap "FOund breaking loop"
                          break
                        end
                    
                end
                
                
            end
      
      ap "Inputs are (AFTER)"
      ap @inputs
      #sleep 4
      #@inputs = Array.newŒ
      ##ap "Job is"
      #ap @name
      #ap inputs_for_job
      
      
            
      #inputs  = inputs_for_job
      
      #for input in inputs_for_job
        
       # job_input               =   WorkflowItemInput.new
        #HARDCODING !!!!!
       # job_input.input_type    =   "bamFile"
       # if File.exists?(input.output_file_name)
       #   job_input.input_value   =   input.output_file_name
       # else
       #   job_input.input_value   =   input.output_file_name + ".bam"
       # end
        
       # ap job_input
       # @inputs << job_input
       # ap "@inputs = "
       # ap @inputs
        
      #end
      
      
      
    end
    
    
     def get_outputs
       
       ap "Inside get_outputs method"
       outputs_array = Array.new
       
        ap "This method has to be written now ...."
        
        
        
        # How to write this?
        # If it is a obj of type "INPUT", then return the bam file (now it is first parameter)
        
        # if not, then what to do? -- Handle this case later
        
        
        if @category == "Input"
              ap "The first form param is"
              ap @form_params[0].param_value
              output_value                          =  WorkflowItemOutput.new
              output_value.output_type              = "bamFile"
              output_value.output_parameter_name    = ""
              output_value.output_file_name         = @form_params[0].param_value 
              output_value.output_identifier        = "output_0"
              outputs_array << output_value
              ap "if its wrong, then it should be"
              ap @form_params[0]
                
              
        else
              ap "Category is not input"
              
              for output in outputs
                  ap output
                  outputs_array << output
                  
              end
              
       end
=begin
  
          
                      param_val = output.output_file_name
                      
                      if param_val == nil || param_val == ""
                            param_val                 = "outputfile_"+Time.new.usec.inspect
                            output.output_file_name   = param_val
                      end
                        
                      if output.output_file_name != nil && output.output_file_name != ""
                          if output.output_parameter_name != nil
                                command += " " + output.output_parameter_name + " " + output.output_file_name
                          else
                                command += " " + output.output_file_name
                          end
                      end
                      
                    end
=end          
             # delete this --end
       
        ap "Returning outputs as"
        ap outputs_array
        
        ap "See if it gives any clue regarding why the input stuff is failing..."
        
        return outputs_array
       
        #for job_output in outputs
          
           #job_output = WorkflowItemOutput.new
           
          
        #end
           
        #@outputs.output_file_name
          
          
        #return outputs
     end
  
  
    def generate_command_line
      
        command = ""
        command_seperator = " "
        
        if @commandformat == "commandformat_2"
          command_seperator = "="
        end
        
        ap "1"
        ap "The work item is"
        ap @name
        command += @commandline
        
        ap "inputs"
        ap inputs
        ap "2"
        
        # These are mandatory inputs
        # So set them properly
        for input in inputs
          
            ap "3"
            ap input
            ap "3a"
            if input.input_parameter_name != nil && input.input_parameter_name != ""
                    
                    command += " " + input.input_parameter_name + command_seperator + input.input_value
                    
            else
                    command += " " + input.input_value
            end
           
        end
        
        ap "How did this succeed? THere was no input_value according to me....."
        
        
        ap "4"
        ap "formparam"
        ap form_params
        #ap "THose were form params"
        #sleep 5
        
        for formparam in form_params
          
          if formparam.param_value != nil && formparam.param_value != ""
                
                if formparam.param_name != nil && formparam.param_name != ""
                    command += " " + formparam.param_name + command_seperator + formparam.param_value
                else
                    command += " " + formparam.param_value
                end
          end
        end
        
        ap "outputs"
        ap outputs
        
        for output in outputs
          
          param_val = output.output_file_name
          
          if param_val == nil || param_val == ""
                param_val                 = "outputfile_"+Time.new.usec.inspect
                output.output_file_name   = param_val
          end
            
          if output.output_file_name != nil && output.output_file_name != ""
              if output.output_parameter_name != nil
                    command += " " + output.output_parameter_name + command_seperator + "./public/files/" + output.output_file_name
              else
                    command += " " + "./public/files/" + output.output_file_name
              end
          end
          
        end 
      
      ap "outputs"
      ap outputs
      
      ap "command is"
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      ap command
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      ap "--"
      #sleep 5
      
      return command
      
    end
  
    def run
      
      
        start_time = Time.now
    
        ap "Running ... and the job id is"
        ap @job_id
        
        ap "Before"
        
        JobManager.add_notification(@job_id, "Running <b>" + @name + "</b>. Started at "+start_time.to_s)
        
        ap "After"
        
        ap @category
        
        
        # These are input files ... these cannot be run...
        if @category != "Input"
                  
                  ap "category is Not input"
                  command = generate_command_line()
                
                  ap "1"
                
                  @STATUS = "RUNNING"
              
                  ap    "********"
                  ap    "GENERIC"
                  ap    "********"
                  
              
                  #command = @commandline
                  
                  ap  "The command for running GENERICTOOL is "
                  ap  command
                  ap  " Next,  running the job"
                  
                    
                  
                  # For jobs like "bam file" there are no commands to be executed
                  if command != nil && command.length > 0
                    
                   
                      begin
                            
                            exit_status_job, stdout_job, stderr_job = run_the_job(command)
                           
                      rescue Exception => e
                        
                            ap "Couldnt execute "
                            ap command
                            ap "There was an exception"
                            ap "-----"
                            exit_status_job   =  -1 
                            stdout_job        =  e.message
                            stderr_job        =  e.message
                            ap "-----"
                            #sleep 5
                      end  
                  end
        else
            exit_status_job   =  0 
            stdout_job        =  ""
            stderr_job        =  ""
        end 
        
        
        
        ap  " running job - DONE"
        
        
        
        
        @STATUS = "COMPLETE"
        
        if exit_status_job.nil?
             
             @STATUS = "ERROR"
             
        elsif
            if exit_status_job == 0
             
              @STATUS = "COMPLETE"
              
            else
              
              @STATUS = "ERROR"
              
            end       
        end
        
        
        #bam_file_output_object = create_output_object(exit_status_job, stdout_job, stderr_job,@output_file)
        
        #store_output_in_database(exit_status_job, stderr_job, stderr_job)
        
        
        
        puts "Output of GENERIC is  " 
        puts "exit code             " + exit_status_job.inspect
        puts "stderr                " + stderr_job
        puts "stdout                " + stdout_job
    
    
        end_time = Time.now
        
        time_taken = start_time - end_time
        
        total_time = time_diff_in_minutes(start_time, end_time)
        
        
        JobManager.add_notification(@job_id, "Finished running " + @name +" at "+end_time.to_s+". Total time taken="+total_time.to_s)
          
          
        store_output_in_database(exit_status_job, stderr_job, stderr_job, @STATUS, start_time , end_time, total_time)
          
          
          
          
          
          
      
    end
    
    
    
    
    
    def store_output_in_database(exit_status, stdout, stderr, status, time_start , time_end, total_time)
    
    
              puts "++++++++++++About to update output in database GENERIC  +++++++++++++"
              ap "Update DB with output --   GENERIC.  And the job id is"
              ap @job_id
              
              
              job_output_row = JobOutput.where("job_id = ? AND widget_id = ?", @job_id.split('_')[-1] , @widget_db_key )
              
              
              puts "did this work?"
              puts job_output_row.inspect
              puts "?"
              
              
              # has_many  assoaciation - hence array or whatever
              # There has to be only on entry -- 
              job_output = job_output_row.first.work_output
              
              if stdout.nil?
                    stdout = "-- None -- "
              else
                if stdout.length == 0
                    stdout = "-- None -- "
                end 
              end
              
              if stderr.nil?
                stderr = ""
              else
                if stderr.length == 0
                  stderr = "-- None -- "
                end
              end
              
              
              
              #:output,  :stdout, :stderr, :exit_code, :name, :inputs, :outputs, :time_start, :time_end, :total_time, :job_id, :status, :command_line
              job_output.stdout             = (stdout)
              job_output.stderr             = (stderr)
              job_output.exit_code          = (exit_status)
              job_output.output             = @output_file
              job_output.job_id             = @job_id
              job_output.time_start         = time_start
              job_output.time_end           = time_end
              job_output.total_time         = total_time
              job_output.inputs             = inputs
              job_output.outputs            = outputs
              job_output.status             = status
              
              
              
              puts "++++++++++++Saving the following data GENERIC"
              puts job_output.stdout
              puts job_output.stderr
              puts job_output.exit_code
              puts job_output.output
              ap job_output.outputs
              ap "HERE"
            #sleep 10
          
              job_output_row.first.save
        
  end
  
  
  
  
  
  
  
  

      
    def validate
      error = nil
      
      return error
    
    end
    
    
    
    def set_jobId(job_id) 
        
        ap "Job Id being set here.... and its value is"
        ap job_id
        @job_id = job_id
    
  end
  
  
  def set_widgetId(widget_id)
    
    
    
    @widget_id = widget_id
    
    puts @widget_id
    split_widgetid = @widget_id.split('_')
    puts split_widgetid
    
    @widget_db_key = split_widgetid[-1]
    puts @widget_db_key
    
  end
  
  
  
   def create_command_line 
    
    
    
        puts  "CREATE command line inside GENERIC"
        
        command_seperator = " "
        
        if @commandformat == "commandformat_2"
          command_seperator = "="
        end
    
        for input in @inputs
          
            
            
            if input.input_parameter_name.nil?
              #ASHWIN
              #To set value, I dont haev the value
              @commandline = " " + input
            else
              @commandline = input.input_parameter_name + command_seperator + input  
            end
          
        end
    
    
    
        return ""
  end
  
  def get_output_as_html(workitem)
            worker_output = WorkflowItemWorkerOutput.new
            output_html = worker_output.get_output_as_html(workitem)
            
        
        return output_html
                     
  end

  def set_input_param(key, value) 
    
    
    ap "Form processing"
    ap "key is"
    ap key
    ap "value"
    ap value
    ap "outputs are"
    ap outputs
    
    
    for output in outputs
      if output.output_identifier == key
          ap "Found output object .. setting value now"
          output.output_file_name   = value
          ap outputs
          
      end
    end
    
    
    for formparam in form_params
      if formparam.input_identifier == key
         ap "found"+formparam.input_identifier
         
         formparam.param_value = value
      end
    end
    
    
  end

end
