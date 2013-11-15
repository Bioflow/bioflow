require "awesome_print"

class WorkflowItemController < ApplicationController

  before_filter :authenticate_user!, :load_foo
  after_filter  :save_foo
  def load_foo
    
    @workflowObjects  = session[:workflowObjects]  || Hash.new
    @connections      = session[:connections]      || Hash.new
  
    @job_id           = session[:job_id]
    
    
  end

  def save_foo
  
    session[:workflowObjects] = @workflowObjects
    session[:connections]     = @connections
    
    session[:job_id]          = @job_id

  
  end
  
  
  
=begin
  
    Gets all the jobs from database and displays
    Also retrieves user saved jobs from SavedJob table
    
=end  
 
  def show
    $stdout = File.new('console.out', 'w')
    $stdout.sync = true
    
    @workflowObjects  =  session[:workflowObjects]  = Hash.new
    @connections      = session[:connections]       = Hash.new
    puts "=================================="
    puts @workflowObjects.inspect
    puts @connections.inspect
    puts "=================================="
    
    
    
 
    @user_saved_jobs  = SavedJob.find(:all, :order => "category")
    
    ap "==========="
    ap "==========="
    ap "==========="
    ap BAM_BASE_DIR
    @servers = BAM_BASE_DIR['Servers']
    ap @servers
    
    
    
    @workflowitem_temp= WorkflowItem.find(:all, :order => "category")
    puts @workflowitem_temp.inspect
    #ap @workflowitem_temp
    
    max_workflow_id = 0
    @allworkitems = Array.new
    ap "+++"
    #ap @workflowitem_temp
    ap "+++"
    for workitem in @workflowitem_temp
      puts workitem.to_s
      ap "WHAT"
    end
    
    
    for workitem in @workflowitem_temp
      puts workitem.class
      ap "workitem is "
      ap workitem
      ap "xxxx" 
      workflowitem_client             = WorkflowItemClient.new()
      workflowitem_client.category    = (workitem.category)
      workflowitem_client.isparent    = (workitem.isparent)
      workflowitem_client.itemid      = (workitem.itemid)
      workflowitem_client.name        = (workitem.name)
      workflowitem_client.parent      = (workitem.parent)
      workflowitem_client.summary     = (workitem.summary)
      workflowitem_client.totalinputs = (workitem.totalinputs)
      workflowitem_client.totaloutputs= (workitem.totaloutputs)
      workflowitem_client.id          = (workitem.id)
      workflowitem_client.inputs      = (workitem.inputs)
      workflowitem_client.outputs     = (workitem.outputs)
    
      @allworkitems << workflowitem_client
      max_workflow_id = max_workflow_id+1
      
      ap workflowitem_client
      ap "------------------"
    end

   
   
    @user_created_jobs = UserCreatedJob.find(:all)
   ap "------------------------------------"
   ap "------------------------------------"
   
    #NEED TO MODIFY THIS FOR INPUTS AND OUTPUTS
    for savedjob in @user_created_jobs
        
        workflowitem_client = WorkflowItemClient.new()
        workflowitem_client.category=("User Saved Job")
        workflowitem_client.isparent=false
        workflowitem_client.itemid=savedjob.itemid
        workflowitem_client.name=(savedjob.jobname)
        workflowitem_client.parent=("root")
        workflowitem_client.summary=(savedjob.summary)
        workflowitem_client.totalinputs=(1)
        workflowitem_client.id          = (savedjob.id)
        #workflowitem_client.workflowitems=(savedjob.jobcontents.workflowObject)
        #workflowitem_client.connections=(savedjob.jobcontents.connections)
        
        max_workflow_id = max_workflow_id + 1
        workflowitem_client.id = max_workflow_id
        
        
        #NOT TESTED ... just copied and pasted from few lines above
        workflowitem_client.inputs      = (workitem.inputs)
        workflowitem_client.outputs     = (workitem.outputs)
      
      
      
        @allworkitems << workflowitem_client
   
    end

    
  
  end



def load

    @workflowitem_temp= WorkflowItem.find(:all, :order => "id")
    
    #@user_saved_jobs   = SavedJob.find(:all, :order => "id")
    
    
    max_workflow_id = 0
    @allworkitems = Array.new
    
    
    for workitem in @workflowitem_temp
      ap workitem
   
      workflowitem_client             =   WorkflowItemClient.new()
      workflowitem_client.category    =   (workitem.category)
      workflowitem_client.isparent    =   (workitem.isparent)
      workflowitem_client.itemid      =   (workitem.itemid)
      workflowitem_client.name        =   (workitem.name)
      workflowitem_client.parent      =   (workitem.parent)
      workflowitem_client.summary     =   (workitem.summary)
      workflowitem_client.totalinputs =   (workitem.totalinputs)
      workflowitem_client.totaloutputs=   (workitem.totaloutputs)
      workflowitem_client.id          =   (workitem.id)
      
      workflowitem_client.inputs      =   (workitem.inputs)
      workflowitem_client.outputs     =   (workitem.outputs)
    
      @allworkitems                   << workflowitem_client
      max_workflow_id                 = workitem.id
    end

   
    @user_created_jobs = UserCreatedJob.find(:all)
   
    for savedjob in @user_created_jobs
        
        workflowitem_client = WorkflowItemClient.new()
        workflowitem_client.category=("User Saved Job")
        workflowitem_client.isparent=false
        workflowitem_client.itemid=savedjob.itemid
        workflowitem_client.name=(savedjob.jobname)
        workflowitem_client.parent=("root")
        workflowitem_client.summary=(savedjob.summary)
        workflowitem_client.totalinputs=(1)
        #workflowitem_client.workflowitems=(savedjob.jobcontents.workflowObject)
        #workflowitem_client.connections=(savedjob.jobcontents.connections)
        
        max_workflow_id = max_workflow_id + 1
        workflowitem_client.id = max_workflow_id
        
        
        @allworkitems << workflowitem_client
   
    end
    
    respond_to do |format|
      format.json { render :json => @allworkitems.to_json }

    end


end




  def load_old
  
      show()
  end


  def allworkflowitems
  
  
    @workflowitems= WorkflowItem.find(:all, :order => "category")
    
    
    
    
  end

  #Each time a new workflow item is created,
  #on the server side, create a new OBJECT which
  #represents the workflow
  #
  # Eg :When samtools sort is added,
  # on the server, create a samtoolsSort object and
  # store it in an array or somewhere

  def newWorkflowitemAdded
  $stdout.reopen('console.out', 'w')
       $stdout.sync = true
          $stderr.reopen($stdout)
    

    @workflowitemId = params[:id]
    @widgetId       = params[:widgetId]
    current_job_id  = params[:jobId]
    is_restore      = params[:isrestore]
    
    
    htmlString = createFormForWorkflowItem(@workflowitemId, @widgetId)


    if is_restore.eql? "no"
      work_obj      = createNewObjectOnServerSide(@workflowitemId, @widgetId)
      
      htmlString    = create_form_for_workflow_item(@workflowitemId, @widgetId, work_obj)
    end
    
 
    respond_to do |format|
    
      format.html { render :text => htmlString }

      end

  end

  def newConnectionAdded
  
  
    
    from_id     =   params[:from]
    to_id       =   params[:to]
    from_anchor =   params[:fromAnchor]
    to_anchor   =   params[:toAnchor]
    is_detached =   params[:isDetached]
    
    
     if is_detached == "true"
              # Need to delete the connections now
              
          
              for conn_info in @connections
           
                 if conn_info[0].id == from_id
                    ap @connections
                    ap conn_info[0].id
                    ap from_id
                    ap @connections
                    ap "Deleting this "
                    @connections.delete(conn_info[0])
                    break
                 end
              end     
     else
            ap "adding new connection"
            #sleep 2
            from_connection_info = ConnectionInfo.new
            from_connection_info.id=from_id
            from_connection_info.anchor=from_anchor
            
            to_connection_info = ConnectionInfo.new
            to_connection_info.id=to_id
            to_connection_info.anchor=to_anchor
            
            ap "BEFORE"
            ap @connections
            @connections[from_connection_info] = to_connection_info
            ap "AFTER"
            ap @connections
        
        
    
     end
    
    


    respond_to do |format|
      format.json { render :json => "OKAY".to_json }
    end

    

  end
  
  
  
  def create_form_for_job_name
  
      job_id = params[:job_id]
      job = Job.find_by_job_id(@job_id)
      
      ap "Creating form for job"
      form_creator = FormCreator.new
      html_str = form_creator.create_form_for_job(job_id, job)
      
      respond_to do |format|
        format.json {render :json => html_str.to_json }
      end
  
  end
  
  # I dont remember whats going on in this method
  # and now I dont have the patience to understand it ... hehe ..
  # it works .. thats all that matters
  # Ashwin - to be deleted
  
  def create_form_for_workflow_item(workflowitemId, widgetId, work_obj)
    puts "Creating form for " +workflowitemId.inspect
    puts "The Id is         " +widgetId.inspect
    
    
    workflowObject_id = workflowitemId + "_" + widgetId
    
    
    workflowObj = nil
    
    
    if @workflowObjects[workflowObject_id] != nil
      workflowObj = @workflowObjects[workflowObject_id]
    end
    
    form_creator = FormCreator.new
    html_str = form_creator.create_form(workflowitemId, widgetId, workflowObj)
    
    

    return html_str
    
  end
  def createFormForWorkflowItem (workflowitemId, widgetId)
    



    puts "Creating form for " +workflowitemId.inspect
    puts "The Id is " +widgetId.inspect
    
    
    workflowObject_id = workflowitemId + "_" + widgetId
    
    
    workflowObj = nil
    
    
    if @workflowObjects[workflowObject_id] != nil
      workflowObj = @workflowObjects[workflowObject_id]
    end
    
    
    
    puts "Anything interesting?"
    form_creator = FormCreator.new
      html_str = form_creator.create_form(workflowitemId, widgetId, workflowObj)
    
    

    return html_str

  end
  
  
  
  

  def createNewObjectOnServerSide(workflowitemId_local, widgetId_local)
    
    
    ap workflowitemId_local
    ap widgetId_local
    
    key_str     =     workflowitemId_local +"_" + widgetId_local
    workitem_on_server = nil
    
    if(workflowitemId_local=="input_bamfile")
      workitem_on_server = createBamFileObject(widgetId_local)

      @workflowObjects[key_str]   = workitem_on_server
    elsif(workflowitemId_local=="samtools_sort")
      workitem_on_server = createSamToolsSortObject(widgetId_local)
      @workflowObjects[key_str]   = workitem_on_server
    
    elsif(workflowitemId_local.start_with?("user_saved_job"))

      
      job_name = workflowitemId_local.split("_").last
      job_retrieved_from_db = SavedJob.find_by_name(job_name)
      workitem_on_server = job_retrieved_from_db
      @workflowObjects[key_str]   = workitem_on_server
      
    elsif(workflowitemId_local.start_with?("twininput"))
      workitem_on_server = create_twin_input_object(widgetId_local)
      @workflowObjects[key_str]   = workitem_on_server
      
      
    else
      
      workitem_on_server = create_generic_object(workflowitemId_local, widgetId_local)
      ap "Creating generic object"
      ap "key str is " +key_str
      ap "The object created is"
      ap workitem_on_server 
      
      @workflowObjects[key_str]   = workitem_on_server
      
    end
  
      ap @connections.inspect
     if @connections.keys.empty? 
        #puts "conn was null"
        
        #ap "THIS SHOULDNT HAPPEN - createNewObjectOnServerSide"
        #sleep 10
        #@connections = Hash.new
        #@values = nil
        #@connections[key_str] = nil
     else
        puts "conn was not null"
     end
    
    
    
    return workitem_on_server
    
  end


  def create_generic_object(workflowitemId, widget_clientid)
    workflowitem_generic_object  = WorkflowItemWorker.new(workflowitemId)
    workflowitem_generic_object.work_item_id=(widget_clientid)
    
    return workflowitem_generic_object
    
  end


  def createSamToolsSortObject(widgetId_local)
    samtoolsSortObj = SamToolsSort.new
    samtoolsSortObj.work_item_id=(widgetId_local)
    
    return samtoolsSortObj
  end

  def createBamFileObject(widgetId_local)
    bamFileObj = BamFile.new("136.novoalign.sorted.bam")
    bamFileObj.work_item_id=(widgetId_local)
    
        

    return bamFileObj
  end
  
  
  def create_twin_input_object(widgetId_local)
    
    twininput = TwinInput.new()
    twininput.work_item_id=(widgetId_local)
    
    return twininput
    
  end



  def formsubmit

    
    
    form_handler = FormHandler.new

     
    message  = form_handler.process_form(params , @workflowObjects, @job_id)
   

    respond_to do |format|
      format.json { render :json =>  message.to_json }
    end
    
    
    
  end
  

  def clearSession
    
    puts "CLEAR SESSSION CALLED"
    puts "+++++++++++++++++++++++++++++"
    puts "+++++++++++++++++++++++++++++"
    
    @workflowObjects = Hash.new
    @connections     = Hash.new
    respond_to do |format|
      format.json { render :json =>  @workflowObjects.length.to_json }
    end
    
    
  end

  def runTheJobsNow
    server = params[:server]
    ap server
    
    queue = 'default'
    
    unless server.nil?
      queue = server  
    end
    

    errors = validate_workflow_items()
    ap "2"
    unless errors.nil?
      errors["status"]  = "Error"
      
      respond_to do |format|
        format.json { render :json =>  errors.to_json }
      end
      
      return
      
    end
    
    ap "3"
    #connection_validation_error = validate_the_connections()
    
    
    #errors = Hash.new
    #if connection_validation_error != nil
    #    send_connection_errors(connection_validation_error)
    #    return
    #end 
    
    
    #workflow_item_errors = validate_workflow_items()
    
    #if workflow_item_errors != nil
    #    send_connection_errors(workflow_item_errors)
    #    return
    #end
    
    temporary_objs = @workflowObjects
    ap "About to run the jobs"
    ap "job id is"
    ap @job_id
    
    jobManager = JobManager.new(@connections, temporary_objs, @job_id)



    #jobManager.runTheJobs()jobManager.delay(:queue => queue).runTheJobs()
    jobManager.runTheJobs()
    
#    jobManager.delay(:queue => 'mittelmanlab').runTheJobs()

    


    JobManager.add_notification(@job_id, "Added job to job queue ")

    ap "xx"
    
    errors = Hash.new
    errors["status"]  = "Success"
    errors["message"] = "Added job to job queue "
    respond_to do |format|
      format.json { render :json =>  errors.to_json }
    end

  end

  def validate_the_connections
    
    ap "Inside validate"
    
    ap "Connections are"
    ap @connections
    ap "Work flow items are"
    ap @workflowObjects
    
    #First check that every workflow item has a connection
    
    
    if @workflowObjects.length == 1
      
        return "Cannot run, only 1 workflow item."
    elsif @workflowObjects.length == 0
        return "Nothing to run."
    end
    
    
    for item in @workflowObjects.keys
      
      if @connections.include? item
        #cool
      else
        return "No connection found for "+ @workflowObjects[item].pretty_name
      end
      
      
    end
    
    
    
    return nil
    
  end
  
  
  def send_connection_errors(validation_error)
        errors = Hash.new
        errors["status"]  = "Failure"  
        errors["message"] = validation_error
        respond_to do |format|
            format.json { render :json =>  errors.to_json }
        end
  end
  
  def validate_workflow_items
       
      errors = Hash.new
      
      #sleep 2
      ap "inside validate"
      ap @connections
      #sleep 2
      
      if @connections.length == 0
        errors["widgetid"]  =  "none"
        errors["message"]   =  "No connections."
        return errors
      end
      
      
      for workitem in @workflowObjects
      
          id = workitem[0]
          number_of_required_inputs = workitem[1].inputs.length
          
          for conn in @connections
          
              if conn[1].id == id
                 number_of_required_inputs = number_of_required_inputs - 1
              end
              
          end


          if number_of_required_inputs != 0
                errors["widgetid"]  =  workitem[1].name
                errors["message"]   =  "Inputs ("+number_of_required_inputs.to_s+") are missing for "+workitem[1].name
                return errors
          end
         
          
      end
      
      
      
      return nil
   
  end
=begin
  


    I THINK ILL DUMP THIS METHOD, INSTEAD I'LL UPDATE
    THE NOTIFICATIONS 
   
=end

  def getJobStatuses
    
    work_outputs = Array.new

    job_keys = @workflowObjects.keys

    for work_item_key in job_keys

      work_item_obj = @workflowObjects[work_item_key]

      work_outputs << work_item_obj

    end

    respond_to do |format|
      format.json { render :json =>  work_outputs.to_json }
    end
  end

  
  def retrieve_notifications
      # respond_to do |format|
      #  format.json {render :json => Array.new }
      # end
      # return
      job_id = params[:jobId]
      puts "THe passed job id is "
      ap job_id
      
      
      job = Job.find_by_job_id(@job_id)
      ap job
      notifs = job.notifications
      ap notifs
      if notifs.nil?
          notifs = Array.new
      end
      
      status = job.status
      if status.nil?
        status="RUNNING"
      end
      
      ap status
      
      output_details = Hash.new
      output_details['status'] = status
      output_details['notifications'] = notifs
      
      
      
      respond_to do |format|
        format.json {render :json => output_details }
      end
      
  end


  def getJobOutput
    
    
    widget_id_param   = params[:widget_id]
    job_id_param      = params[:jobId]
    work_obj          = session[:workflowObjects]
    
    ap widget_id_param
    ap job_id_param
    ap work_obj
    
    if widget_id_param == nil || job_id_param == nil || work_obj == nil
        ap "NILLLLLLLLLLLLL"
    end


    output_requested_for =  work_obj[widget_id_param]
    
    
    current_job = Job.find_by_job_id(job_id_param)
    
    after_split = widget_id_param.split('_')
    
    
    
    
    requested_job_output = JobOutput.where("job_id = ? AND widget_id = ?", current_job.id, after_split[-1])
    
    puts "requested_job_output"
    puts requested_job_output.inspect



    for job_output in requested_job_output
      
      if job_output.widget_id == widget_id_param
        
        
        
        
        
      end
      
      
    end
    
    puts "Check here for null related errors -----"
    puts "----------------------------------------"
    puts "----------------------------------------"
    puts "----------------------------------------"
    ap requested_job_output.inspect
    ap "Output requested for"
    ap output_requested_for
    
    html_output = ""
    
    if requested_job_output == nil || requested_job_output.length == 0
      html_output = "<table class= \"output-table-style\"><tr> <td>Output not available yet </td></tr></table>" 
   else
      html_output = output_requested_for.get_output_as_html(requested_job_output.first.work_output)
    end
    
    

    respond_to do |format|
      format.html { render :text => html_output }
    end

  end
  
  
  
  def startnewjob
        current_job = Job.new()
        current_job.jobname = Time.now.to_s
        
        begin
          
            current_job.save!
        
        rescue Exception => e
            ap "exception has occured"
            ap e
        end
        
        current_job.job_id=("job_id_"+current_job.id.to_s)
        current_job.jobname=("job_id_"+current_job.id.to_s)
        current_job.save
        
        
        @job_id = current_job.job_id
        session[:job_id] = @job_id
        
        
        JobManager.add_notification(@job_id, "Created new job , job Id is " +current_job.job_id)
        
        output = Hash.new()
        
        output['job_id'] =  current_job.job_id
        output['notification'] = "Created new job. job Id is " +current_job.job_id
        
        ap "responding now"
        respond_to do |format|
          format.json { render :json => output.to_json }
        end
        
  end
  


=begin
 I wrote this method with the intention of saving the job
 and putting it on the left accordion
 
 Now I realise that I should generate new IDs for all the 
 individual widgets when I drag and drop it .
 
 So, saving IDs is not useful here.
 
 IDs will come useful when I have to "view output" of a long running
 task. User runs task today, comes tomorrow to check output. That case we
 need ID. And, this usecase should be supported from teh JOB table,
 not from the saved jobs table.
 
 
 SAVEDJOBs table should be used for populating the left accordion only. 
=end

def savethejob
  
    current_job_id      = params[:jobId]
    
  
  # First get the job from database
    current_job = Job.find_by_job_id( current_job_id )
  
  
   # 1 ) OK - so let me create a new object which contains
  # both workflowobjects and  connections in it
  
=begin  
  user_saved_obj = UserSavedJob.new()
  user_saved_obj.workflowobjects=(@workflowObjects)
  user_saved_obj.connections=(@connections)
  puts user_saved_obj.inspect
=end
  
    saved_job = SavedJob.new()
    saved_job.workflowobjects=(@workflowObjects)
    saved_job.connections=(@connections)
    saved_job.name=(Time.new.usec.inspect)
    saved_job.category=("Saved Job")
    saved_job.parent=("root")
    saved_job.isparent=(false)
    saved_job.totalinputs=(1)
    saved_job.totaloutputs=(1)
    saved_job.summary=("Summary tbd")
    saved_job.itemid=("user_saved_job")
  
  
    saved_job.save
  
  # 2) and I can save this object in database
  
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"
    ap "SAVING HERE"



  
    respond_to do |format|
      format.json { render :json => "Saved successfully".to_json }
    end

  
  
end 

def gethtmlforwidget
  
  widgetid   = params[:widgetid]
  jobid      = params[:jobId]
  objectname = params[:objectname]
  
  widgetHTML = '<div class="widget-content inputItem_file" id=' \
            +   widgetid \
            +   ' onclick= widgetClicked(' \
            +   widgetid \
            +  ')' \
            +   ' >' \
            + '<p><br>' \
            +  objectname \
            +   '</br></p>' \
            +   '</div>' 
            
            
  
  
  respond_to do |format|
    format.json {render :json => widgetHTML.to_json }
    
  end 
  
end
  
  
  
  def createShellCommands
    
  
    
    
    temporary_objs = @workflowObjects
    jobManager = JobManager.new(@connections, temporary_objs, @job_id)
    
    command_lines = jobManager.createCommandLine()
 
    respond_to do |format|
      format.json {render :json => command_lines.to_json}
    end
  end
  
  
  
  def test_data_recieved
    test = params[:data]
    
    
    puts test
    respond_to do |format|
      format.json {render :json => "DONE".to_json}
    end
  end
  


  def saveUiCoordinates
    ap "Params are ====================================="
    ap params
    
    temp           = params[:widget]
    
    widget_name    = params[:widgetname]
    widget_summary = params[:widgetsummary]
     
    job_id_param = params[:job_id]
    
    rubyobject =  JSON.parse(temp)
    ap  "====="
    ap rubyobject
    ap  "=====" 
      
    objs_in_client = Hash.new
    
    for  o in rubyobject
      puts "--"
      
      widget_id = o['widgetid']
      
      
      
        job_keys = @workflowObjects.keys
    
        for work_item_key in job_keys
    
          work_item_obj = @workflowObjects[work_item_key]
          
          puts work_item_obj.inspect + "  SEE ?s"
      
          if work_item_obj.work_item_id == widget_id
             work_item_obj.posX = o['posX']
             work_item_obj.posTop = o['posTop']
            
          end
          
        end
    end
    
    job_keys = @workflowObjects.keys
    
    puts "Print them once again"
    for work_item_key in job_keys
      work_item_obj = @workflowObjects[work_item_key]
      puts ""
      puts ""
      puts work_item_obj.inspect
     
    end
    ap "1111"
    jobContent = JobContent.new(@workflowObjects, @connections)
    ap "2222"
    
    current_job = Job.find_by_job_id(@job_id)
    
    
    ap "The retrieved job from database is"
    puts current_job.inspect
    
    current_job.jobContents = jobContent
    
    ap "the jobContent dude object is"
    if jobContent.instance_of?(JobContent)
      ap "ISNTANCE"
    end
    jc = jobContent
    ap jc.class
    ap "x"
    ap jobContent.class
    ap jobContent
    ap "END"
    
    
    #user_created_job = UserCreatedJob.find_by_job_id(@job_id)
    #if user_created_job.nil?
      user_created_job = UserCreatedJob.new
    #end
    user_created_job.job_id         = current_job.job_id
    user_created_job.work_obj       = current_job.work_obj
    user_created_job.input_ids      = current_job.input_ids
    user_created_job.output_ids     = current_job.output_ids
    ap "AASDSADS"
    ap current_job.jobContents
    ap "@@@@"
    user_created_job.jobContents    = current_job.jobContents
    
    ap user_created_job.jobContents.class
    ap "AASDSADS"
    
    user_created_job.notifications  = current_job.notifications
    user_created_job.status         = current_job.status
    user_created_job.jobname        = widget_name
    user_created_job.summary        = widget_summary
    user_created_job.user_id        = current_job.user_id
    user_created_job.didexecute     = current_job.didexecute
    user_created_job.itemid         = Time.now.usec
    user_created_job.connections    = @connections
    user_created_job.workflow_items = @workflowObjects
    
    ap "AASDSADS"
    
    begin
      ap "SAVING user created job - it looks like"
      ap user_created_job
      
      returned_object = user_created_job.save!
      ap "jobContents"
      ap user_created_job.jobContents
      
      
      processed_yaml = process_this_string(user_created_job.jobContents)
      
      unless processed_yaml.nil?
        ap processed_yaml
      
        my_job_contents    = ActiveRecord::Base.connection.quote(processed_yaml)
        id_to_update = user_created_job.id
        
        query = "UPDATE  user_created_jobs SET jobContents = #{my_job_contents} WHERE id = #{id_to_update}"
  
        ActiveRecord::Base.connection.execute(query);
        
        #user_created_job.jobContents    = processed_yaml
        #user_created_job.jobContents    =  ""
        #user_created_job.save! 
  
      end
        rescue Exception => e
      ap "EXCEPTION !!!!!!"
      ap e
    end
      
    
    
    
    
    
    
    current_job.jobname =  widget_name
    
    current_job.save
    
    current_job_1 = Job.find_by_job_id(@job_id)
    puts "SAVED?"
    puts current_job_1.inspect
    
   
    respond_to do |format|
      format.json {render :json => "Saved Job to DB".to_json}
    end
    
  end

  
  def process_this_string(yaml_bad_format) 
    
    if yaml_bad_format.include?("!ruby/object:ConnectionInfo ?")
      ap "THIS YAML HAS BAD FORMAT"
      yaml_bad_format["!ruby/object:ConnectionInfo ?"] = "? !ruby/object:ConnectionInfo"
    
      return yaml_bad_format
    else 
      return nil
    end
    
    
    
    
  end

  def restorejob
    $stdout = File.new('console.out', 'w')
    $stdout.sync = true
    
    ap "Inside restore job"
    ap "RELOAD PLZ"
    
    job_id_restore  = params[:jobId]
    
    puts job_id_restore.inspect
    
    
    
    #job = Job.find_by_job_id(job_id_restore)
    
    #if job.nil?
    job = UserCreatedJob.find_by_jobname(job_id_restore)
    #end
    
    
    
    puts "The job from database - Have the objects deserialised?"
    ap job.class
    ap job

    connections = job.connections
    ap "Connections is of"
    ap connections.class
    ap "--"
    ap connections
    #sleep 2
    
    ap "workflow items"
    ap job.workflow_items.class
    ap "--"
    ap job.workflow_items
    ap "--"
    #sleep 2

    #if job.respond_to?('jobContents')
     job_contents = job.jobContents
    #else
     # job_contents = job.jobcontents  
    #end
    
   #some_var = YAML::load(job.jobContents)
   #ap some_var
   #ap some_var.class
   
   #sleep 2
    
   #deserializeManually(jobContents) 
    
   ap job.jobContents.class
   if job.jobContents.instance_of?(JobContent)
     ap "deserialized"
   else
     ap "failed to deserialize"
   end 
   
   ap "HERE"
    ap job_contents.workflowObjects
    for key in job_contents.workflowObjects.keys
      ap "key is"
      ap key
      @workflowObjects[key] = job_contents.workflowObjects[key]
      
    end
    
    
    #@workflowObjects = job_contents.workflowObjects
    for key in job_contents.connections.keys
      
      ap "key is"
      ap key
      @connections[key] = job_contents.connections[key]
    end
    
    #@connections     = job_contents.connections
    #sleep 2   
    puts "Retrieved workflow objs"
    ap @workflowObjects
    puts "Retrieved connections"
    ap @connections
    
    
    
    connections_array = Array.new
    for conn in @connections
      ap "See what these values are"
      connections_array << conn
    end
    
    job.jobContents.connections = connections_array
    ap "JSON STUFF"
    ap job.as_json
    @connections = Hash.new
    respond_to do |format|
        format.json {render :json => job.as_json}
    end
    
    
    
    
  end



  def getJobsToRestore
  
    job = Job.find(:all, :order => "id DESC", :limit => 10, :select => "job_id")
    
    ap job
    
    respond_to do |format|
        format.json {render :json => job.to_json}
    end
  
  end



  def removeWorkflowitem
    
    workflowitem_id = params[:widgetId]
    job_id          = params[:jobId]
    
    ap workflowitem_id
    ap job_id
    
    ap @workflowObjects
    #ap @connections
    
    keys = @workflowObjects.keys
    for item in keys
      
      ap item
      if item.include? workflowitem_id
          ap item +" contains " +workflowitem_id
          @workflowObjects.delete(item)
      end
    end
    
    ap @workflowObjects
    
    
    
=begin    
    ap "THIS WONT WORK BECAUSE CONNECTIONS STUFF HAS BEEN CHANGED"
    sleep 10
    
    workflowitem_id = params[:widgetId]
    job_id          = params[:jobId]
    
    ap workflowitem_id
    ap job_id
    
    ap @workflowObjects
    #ap @connections
    
    keys = @workflowObjects.keys
    for item in keys
      
      ap item
      if item.include? workflowitem_id
          ap item +" contains " +workflowitem_id
          @workflowObjects.delete(item)
      end
    end
    
    ap @workflowObjects
    
    
    
    ap "===connections==="
    ap "connections - before"
    ap @connections
    
    keys = @connections.keys
    
    ap "keys are "
    ap keys
    
    for item in keys
      
            ap "Currently processing "
            ap item
            
            
            
            if item.include? workflowitem_id
                    ap item + " contains " +workflowitem_id
                    ap "Deleting "
                    ap item
                    @connections.delete(item)
          
            else 
                        #THE key is not the item
                        #Is value a part of the item
                        #values in an array
              
                          values = @connections[item]
                          if values.nil?
                              # Nothing to do here
                          
                          elsif values.length == 1
                            
                               
                                
                              
                                @connections[item] = nil
                            
                            
                          else
                            
                                for value in values
                                      if value.include? workflowitem_id
                                        ap "Deleting "
                                        ap value
                                        values.delete(value)
                                      end
                                end
                            
                            
                          end 
            
              end
      
    end
    
    ap "connections - after"              
    ap @connections

=end    
    
    respond_to do |format|
        format.json {render :json => "deleted "+workflowitem_id.to_json}
    end
    
    
  end



end
