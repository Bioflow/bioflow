class JobManager


=begin

THIS IS HOW @work_flow_items looks

 {
   
   "input_bamfile_widget3"=>#<BamFile:0x007f9189e76c48 @baseDir="/Users/ashwin/Documents/workspaces/rubysource/workflow", @bamFile="no
vo_30_sorted.bam", @STATUS="PENDING", @work_item_id="widget3">, 

   "samtools_sort_widget4"=>#<SamToolsSort:0x007f9189e769f0 @input_file
="", @baseDir="", @STATUS="PENDING", @on="", @m="", @output_file="", @samtools_sort_output=#<SamToolsSortOutput:0x007f9189e76810 @ou
tput_file_name="", @output_file_dir="", @stdout="", @stderr="", @exit_code=-100>, @work_item_id="widget4">

}
 
 
 
 THIS IS HOW @connections looks like
 
 {
   "input_bamfile_widget3"=>nil, 
   
   "samtools_sort_widget4"=>["input_bamfile_widget3"]
 }


=end

  
  
  
  
  #need to make this guy singleton
  # cannot do singleton because job id keeps changing
  def initialize(connections_hash , work_flow_items_hash, this_job_id)
    
   
    @work_flow_items = work_flow_items_hash
    @connections     = connections_hash
    @job_id          = this_job_id
    
    
    
  end
  
  
 
  
  def runTheJobs
  
  
        
    execute_jobs_in_order()
    
    
    
    this_job = Job.find_by_job_id(@job_id)
    this_job.status = "COMPLETE"
    this_job.save
    
    nonstatic_add_notification(@job_id, "Finished executing the job " +@job_id)
    

 end
 
 
 
 
=begin
  
 
 def change_ids_in_saved_jobs
       cur_time =  Time.new.usec
       
       
       keys_temp = @work_flow_items.keys
       #keys_connections = @connections.keys
       puts "======================="
       puts @connections.inspect
       
       # do some preprocessing
       # If saved jobs are being executed, change their IDs now
       
       
       
       for k in keys_temp
         
         old_key_to_new_key_map = Hash.new
         
         if k.starts_with?("user_saved_job")
           #these need to be edited
           
                    puts "the value of k is"
                    puts k.inspect
           
            
                     saved_job_work_items =  @work_flow_items[k].workflowobjects
                     puts "contents"
                     puts @work_flow_items.inspect
                     puts "contents 2"
                     puts saved_job_work_items.inspect
                     saved_job_keys = saved_job_work_items.keys
          
                     saved_job_keys.each do |key|
                         new_key = key +"_" + cur_time.inspect
                         cur_time = cur_time  + 1
              
                         old_key_to_new_key_map[key] = new_key
                         
                         saved_job_work_items[new_key] = saved_job_work_items[key]
                         
                         saved_job_work_items.delete(key)
                     end
           
                     puts "()))))))))))))))))((((((((((()))))))))))"
                     
                     saved_job_conns = @work_flow_items[k].connections
                     
                     puts saved_job_conns.inspect
                     
                     puts saved_job_conns.inspect
                     saved_job_conns.keys.each do |c|
                                 new_array = nil
                                 
                                 values = saved_job_conns[c]
                                 if values != nil
                                    for v in values
                                       new_array = Array.new
                                       new_array << old_key_to_new_key_map[v]
                                     end
                                end
                             
                               saved_job_conns[old_key_to_new_key_map[c]] = new_array
                               puts saved_job_conns.inspect
                               
                               saved_job_conns.delete(c)
                               puts saved_job_conns.inspect
                 
                    end
           
          
           # Add these new tasks to the main tasks and remove old task
           
           puts "original items"
           puts @work_flow_items.inspect
           
           
           @work_flow_items.delete(k)
           puts "After delete - step 1"
           puts @work_flow_items.inspect
           
           
           saved_job_work_items.keys.each do |nkey|
              @work_flow_items[nkey] = saved_job_work_items[nkey]
           
           puts "Added one element"
           puts @work_flow_items.inspect
           end
          
          
           
          # this is temporary fix
          
          # Find the one JOb with NIL dependency
          # Give this task teh output of the previous tasl
          # This wont work when multiple inputs will be supported
          
          
          vals = @connections[k]
           
          
          saved_job_conns.keys.each do |c|
            
            if saved_job_conns[c] == nil 
               saved_job_conns[c]  = vals
            end
            
            puts "the connections are :"
            puts @connections.inspect
            @connections[c] = saved_job_conns[c]
            @connections.delete(k)
            puts @connections.inspect
          end  
           
           
         end
      end 
 end
=end 
 
=begin
 what I am going to do for the JOBS is this
   
   Whoever has null, Ill give that guy the I/P
   Ill work on the JOB feature later
   It was a mistake to start now
   So many other things can be done right now !!!!
    
=end
 
 def execute_jobs_in_order
   
         
       nonstatic_add_notification(@job_id, "Running job from queue job id=" +@job_id)
        
       #These are the workflow items
       keys_temp        = @work_flow_items.keys

       #These are the connections
       keys_connections = @connections.keys
      
      
       create_outputs_for_jobs(@work_flow_items, @connections)
       
     
       keys_temp           = @work_flow_items.keys

       keys_connections    = @connections.keys
       





  
       all_jobs_done       = false


       
       while !all_jobs_done
         ap "ENTERING WHILE LOOP HERE"



                    all_jobs_done = true
                  
                     
                    for temp_key_workitem in keys_temp
                              ap "ENTERING FOR LOOP HERE"
                        
                              
                              
                              
                              if JobStatus.is_status_non_teriminal(@work_flow_items[temp_key_workitem].STATUS)
                                    all_jobs_done = false
                                    # Just to check that there is atleast one job to run
                              end
                  
                  
                              #For each connection item É.                         
          


                              # Get all connections of the work item under consieration 

                              @values = get_all_connections(temp_key_workitem)

                              
                              if @values == nil || @values.length == 0
                                     
                                    ap "THIS SHOULD BE A INPUT OBJECT - NOTHING TO RUN"
                                    tempp = @work_flow_items[temp_key_workitem]
          
            
                                    if JobStatus.is_status_non_teriminal(@work_flow_items[temp_key_workitem].STATUS)
                                          @work_flow_items[temp_key_workitem].set_jobId(@job_id)
                                          @work_flow_items[temp_key_workitem].set_widgetId(temp_key_workitem)
                                          @work_flow_items[temp_key_workitem].run()
                                    end
          
                                    
                                    @work_flow_items[temp_key_workitem].STATUS = "COMPLETE"
                                    # ALL  RIGHT INPUT OBJECT HAS RUN NOW É NOW GO TO NEXT OBJECT
                                    # UNDER CONSIDERATION
            
                              else
            
                                    # These jobs haveinputs -- gotta set them before RUNNING
                                    
                                    
                                    can_be_executed_now = true
                                    

                                    for conn_info in @values

                                          job = conn_info[0].id
                                          ap "checking dependency -- in gangsta accent"
                                          ap "The job " 
                                          ap @work_flow_items[temp_key_workitem].name
                                          ap " is under consideration"
                                          ap "The job that has to be complete is "
                                          ap  @work_flow_items[job]
                                          ap "and its name is"
                                          ap  @work_flow_items[job].name 

                                          ap "--"
                                          
                                          if @work_flow_items[job].STATUS != "COMPLETE"
                                               ap "Dependency not met -- because this job aint complete"
                                               ap "------------"
                                               ap "----start---"
                                               ap @work_flow_items[job]
                                               ap "------------"
                                               ap "----end-----"
                                               can_be_executed_now = false
                                             
                                               break
                                          end
                                    end
                                    
                                    
                                    
                                    if can_be_executed_now == true
                                      
                                      
                                          ap ""
                                          ap "Dependency met"
                                          ap ""
                                          
                                          
                                          if @work_flow_items[temp_key_workitem].STATUS != "COMPLETE"
                                            
                                                 input_jobs  = get_all_inputs(temp_key_workitem)
                                                 ap "Got all inputs"
                                                 ap "The inputs retrieved are "
                                                 ap input_jobs
                                                 
                                                 for input_job1 in input_jobs
                                                    ap input_job1.class
                                                    ap input_job1
                                                 
                                                    
                                                 end
                                                         
                                                 for input_job in input_jobs
                                                    
                                                        output_object = input_job.get_outputs()
                                                        
                                                        # "setting input on ......................"
                                                        ap input_job
                                                        
                                                     
                                                        @work_flow_items[temp_key_workitem].set_inputs(output_object, @values, input_job.widget_id)
                                                 end
                                                                              
                                                 
                                                 # "setting job id from job manager as "
                                                 
                                                 @work_flow_items[temp_key_workitem].set_jobId(@job_id)
                                                 @work_flow_items[temp_key_workitem].set_widgetId(temp_key_workitem)
                                                 
                                                 #Running job 
                                                 @work_flow_items[temp_key_workitem].run()
                                             
                                          end
                                          
            
                                    
                                    end
                                  
                                  
                                  
                                  
                                end
                            end
                     
       end
       
   

 end
 
 

  def get_all_connections(workitem_id)
    
    ap "Let me understand which ID belongs to whom"
    
    ap @work_flow_items

    values = Array.new
    
        for connection_info in @connections
          
          ap "conns"
          ap @connections
          ap "conninfo"
          ap connection_info
          ap connection_info.class
          ap connection_info[1]
          ap connection_info[1].class
                  
            if connection_info[1].id == workitem_id
                values << connection_info
            end
    
        end
    
    return values

  end

=begin
 This method creates and saves output objects in database.
 This is a little wrong, because it checks for object type and creates
 the output objects.
 Instead it should be superClassType.createOutput() and the abse
 class should create output object based on the type 
=end
 
 def create_outputs_for_jobs(work_flow_items, connections)
 
    
    puts "creating outputs here "
    
    current_job                 = Job.find_by_job_id( @job_id )
    current_job.status          = "RUNNING"
    current_job.didexecute      = true
    
    keys_work_item              = @work_flow_items.keys
    
    
    
    
    for key  in keys_work_item
      
         workitem = @work_flow_items[key]
      
      
         if workitem.instance_of? BamFile
          
              puts "todo - bam file"
          
          
          
        elsif workitem.instance_of? SamToolsSort
                current_job_output = SamToolsSortOutput.new()
                
                widget_id = key
                
                puts  widget_id
                split_widgetid =  widget_id.split('_')
                puts split_widgetid
                
                widget_db_key = split_widgetid[-1]
                puts  widget_db_key
                current_job.jobOutputs.create(:work_output => current_job_output, :widget_id => widget_db_key)
              
        
        elsif workitem.instance_of? WorkflowItemWorker
          
          #:inputs, :outputs, :time_start, :time_end, :total_time, :job_id, :status, :command_line
                current_job_output         = WorkflowItemWorkerOutput.new
                current_job_output.name    = workitem.name
                current_job_output.inputs  = workitem.inputs
                current_job_output.outputs = workitem.outputs
                current_job_output.status  = "PENDING"
                  
                widget_id         =  key
                split_widgetid    =  widget_id.split('_')
                widget_db_key     =  split_widgetid[-1]
                
                current_job.jobOutputs.create(:work_output => current_job_output, :widget_id => widget_db_key)
                
                
          
          
        elsif  current_job_output = TwinInputOutput.new()
                
                widget_id = key

                split_widgetid =  widget_id.split('_')
                
                widget_db_key = split_widgetid[-1]

                current_job.jobOutputs.create(:work_output => current_job_output, :widget_id => widget_db_key)
                
        end
        
         
      
    end
 
    ap "Next, write to DB"
    
    
    ap "saving job now"
    ap "The id of the current job is "
    ap current_job
    
    begin
    
      current_job.save!
      
    rescue Exception => e
      ap e
    end
    
    
 
 end
 
 
 def get_all_inputs(key_in_workitem)
   #ap "Inside get_all_inputs method"
   #ap "--------"
   #ap "--------"
   
   #ap "What are the ids of workflow items"
   #ap @work_flow_items
   #sleep 2
   #sleep 5
   ap "THis is not working"
   ap "Getting inputs for "+key_in_workitem.to_s
   ap "The connction object is"
   ap @connections
   input_objs = Array.new
   for conn_info in @connections
     
         ap "conn_info is"
         ap conn_info
         ap conn_info[1].id
         ap key_in_workitem
         
         
         if conn_info[1].id == key_in_workitem
            
            some_obj        = @work_flow_items[conn_info[0].id]
            ap "Input is" 
            ap some_obj
            #sleep 5
            input_objs      << some_obj
         end
     
   end
   
     ap "returnong" 
     ap input_objs
     ap ""
     #sleep 5
     return input_objs
   end
=begin
  
   
   input_obj_ids = @connections[key_in_workitem]
   
   for items in input_obj_ids
     some_obj = @work_flow_items[items]
     input_objs << some_obj
   end

   
   puts "The input was "
   puts key_in_workitem
   puts "The values being returned are"
   puts input_objs.inspect
   return input_objs
   
   
 end
=end 
 

  def reset_job_statuses
    
    keys_temp = @work_flow_items.keys
    
        for temp_key_workitem in keys_temp
            @work_flow_items[temp_key_workitem].SIMULATEDSTATUS = "PENDING"
        end    
    
  end



  def createCommandLine
    
      ap "THIS IS PENDING"
      ap "IS THIS USED AT ALL -- createCommandLine"
      #sleep 10
       
       temporary_workflow_items = @work_flow_items.clone
       temporary_connection     = @connections.clone
  
       keys_temp                = temporary_workflow_items.keys
       keys_connections         = temporary_connection.keys
       
       
       command_lines            = Array.new 
       
       
      
       all_jobs_done = false
       
       
      while !all_jobs_done
       
           all_jobs_done = true
           
           
           for temp_key_workitem in keys_temp
  
                    if temporary_workflow_items[temp_key_workitem].SIMULATEDSTATUS != "COMPLETE"
                        all_jobs_done = false
                    end
           
           
           
              
                    for job_key_conns in keys_connections
  
                        
                              if job_key_conns.id == temp_key_workitem
          
                            
                                    temporary_values  = temporary_connection[temp_key_workitem]
                            
                                    if temporary_values == nil
                                          
                                          tempp = temporary_workflow_items[temp_key_workitem]
                  
                                          if temporary_workflow_items[temp_key_workitem].SIMULATEDSTATUS != "COMPLETE"
                                             #temporary_workflow_items[temp_key_workitem].run()
                                             command_lines << temporary_workflow_items[temp_key_workitem].create_command_line()
                                          end


                                          temporary_workflow_items[temp_key_workitem].SIMULATEDSTATUS = "COMPLETE"

                  
                                    else
                                          can_be_executed_now = true
                                                for job in temporary_values
                                                      
                                                      if temporary_workflow_items[job].SIMULATEDSTATUS != "COMPLETE"
                                                         can_be_executed_now = false
                                                         break
                                                      end
                                               end
                                          
                
                                                if can_be_executed_now == true
                      
                      
                                                      if temporary_workflow_items[temp_key_workitem].SIMULATEDSTATUS != "COMPLETE"
                                                        
                                                         input_jobs  = get_all_inputs(temp_key_workitem)
                                                         
                                                         for input_job in input_jobs
                                                            
                                                            output_object = input_job.get_outputs()
                                                            
                                                            temporary_workflow_items[temp_key_workitem].set_inputs(output_object, @connections, input_job.itemid)  
                                                         end
                                                                                      
                                                         
                                                         temporary_workflow_items[temp_key_workitem].set_jobId(@job_id)
                                                         temporary_workflow_items[temp_key_workitem].set_widgetId(temp_key_workitem)
                          
                                                       #temporary_workflow_items[temp_key_workitem].run() 
                                                         
                           
                                                         
                                                         command_lines << temporary_workflow_items[temp_key_workitem].create_command_line()
                                                         temporary_workflow_items[temp_key_workitem].SIMULATEDSTATUS = "COMPLETE"
                                                      end
                                                  
                        
                                                
                                              end
                                
                                
                                
                                   # ENd else
                                  end
                     #End if
                    end
              
              
                # End for
                end    
           
           # END for
           end
           
        # END while
       end
       
       reset_job_statuses()
       
       puts "THE COMMAND LINE IS"
       
       
       puts command_lines.inspect
       
       return command_lines
       
       
    #END WHILE   
    
    
    
    end
  


  def self.retrieve_notifications(job_id)
    
      job = Job.find_by_job_id(job_id)
      
      ap job
      
      if !job.nil?
        return job.notifications
      else 
        return nil
      end 
  
  
  end
  
  
  def nonstatic_add_notification(job_id, notification)
  
      job = Job.find_by_job_id(job_id)
      
      ap "=================="
      ap "====NON-STATIC===="
      ap "=================="
      ap "================="
      ap job
      ap job_id
      ap notification
      
      if job.notifications == nil
          notifs = Array.new
          notifs << notification
          job.notifications = notifs;
          job.save
      else
          notifs = job.notifications
          notifs << notification
          job.notifications = notifs
          job.save
      end
   
  end

  def self.add_notification(job_id, notification)
      
      job = Job.find_by_job_id(job_id)
      
      ap "================="
      ap "================="
      ap "================="
      ap "================="
      ap job
      ap job_id
      ap "---- notification ----"
      ap notification
      ap "------"
      
      if job.notifications == nil
          notifs = Array.new
          notifs << notification
          job.notifications = notifs;
          job.save
      else
          notifs = job.notifications
          notifs << notification
          job.notifications = notifs
          job.save
      end
      
  end
  

    
    
end
