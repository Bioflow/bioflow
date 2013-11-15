
class AddWorkflowitemController < ApplicationController


  def show
    
    
    @workflowitem_temp= WorkflowItem.find(:all, :order => "category")
    
    @user_saved_jobs  = SavedJob.find(:all, :order => "category")
    
    
    @categories = Array.new
    
    
    
    
    
    max_workflow_id = 0
    @allworkitems = Array.new
    
    for workitem in @workflowitem_temp
   
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
      
      ap workflowitem_client.category
      unless @categories.include? (workflowitem_client.category)
        @categories <<   workflowitem_client.category
        ap ".." + workflowitem_client.category
      end
      
    end

   
   
    @user_created_jobs = UserCreatedJob.find(:all)
   
   
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
  
  def create_new_workflowitem
  
      
      @workflow = WorkflowItem.new
      
      show()
      
      respond_to do |format|
        format.html
      end
  end
  
  def create
    
  end
  
  
  def create_input_identifier(suffix)
    
    return "input_"+suffix.to_s
    
  end
  
  def create_output_identifier(suffix)
    
    return "output_"+suffix.to_s
    
  end
  def create_new_workflowitem_formsubmit
      
      ap params
      
      name              = params[:name]
      ap "======================"
      summary           = params[:summary]
      category          = params[:addcategory]
      
      number_of_inputs  = params[:inputs]
      
      inputs            = Array.new
      
      command_format = params[:paramsformat]
      ap command_format
      #sleep 1
      
      begin

        inputs_count      =  Integer(number_of_inputs)
      rescue
        inputs_count = 0

      end
      
      i=0
      
      input_identifier_counter  = 0
      output_identifier_counter = 0
      
      
      while i < inputs_count do
         
          input_type_name = "input_type_" + i.to_s
          input_type      = params[input_type_name]
          
          param_name      = "param_input_" + i.to_s
          param_label     = "label_input_" + i.to_s
          
          param           = params[param_name]
          
          
          input_id = create_input_identifier(input_identifier_counter)
          input_identifier_counter += 1
          
          
          workitem_input  = WorkflowItemInput.new
          workitem_input.input_type             = input_type
          workitem_input.input_parameter_name   = param
          workitem_input.input_parameter_label  = params[param_label]
          workitem_input.input_identifier       = input_id
                     
          inputs << workitem_input
          
          i = i + 1
          
      end
      
      summary         = params[:summary]
      category        = params[:addcategory]
      
      outputs_count = 1
      
      
     
      
      # FOR NOW -- ITS 1 ALWAYS
      # outputs_count =  Integer(outputs)
      output_type    = params[:output_type]
      
      
      #### WHAT IS GOING ON HERE ?
      
      output                         = WorkflowItemOutput.new
      output.output_type             = output_type
      output.output_parameter_name   = "PENDING CLIENT SIDE"
      outputs = Array.new
      outputs << output
      
      
      #NEED TO PUT IN SEPERATE METHODS !!!!!!
      number_of_outputs  = params[:outputs]
      
      outputs            = Array.new
      
      begin

        outputs_count      =  Integer(number_of_outputs)
      rescue
        outputs_count = 0

      end
      
      i=0
      
      while i < outputs_count do
         
          output_type_name = "output_type_" + i.to_s
          ap "output type name is"
          ap output_type_name
          output_type      = params[output_type_name]
          ap "oputpt type is"
          ap output_type
          
          param_name      = "param_output_" + i.to_s
          param_label     = "label_output_" + i.to_s
          
          ap  "param_name"
          ap param_name
          #sleep 2
          param           = params[param_name]
          ap "params"
          ap params
          #sleep 2
          
          
          output_id = create_output_identifier(output_identifier_counter)
          output_identifier_counter += 1
          
          
          workitem_output  = WorkflowItemOutput.new
          workitem_output.output_type           = output_type
          workitem_output.output_parameter_name = param
          workitem_output.output_parameter_label  = params[param_label]
          workitem_output.output_identifier     = output_id
                     
          outputs << workitem_output
          
          i = i + 1
          
      end
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
       
      executable = params[:executable]
      
      
      
      no_of_form_params = params[:formparams]
      
      i=0
      
      
      form_params                =  Array.new
      begin
        no_of_form_params_int    =  Integer(no_of_form_params)
      rescue
        no_of_form_params_int    = 0
      end
      
      while i < no_of_form_params_int do
         
          form_param_name           = "formparam_" + i.to_s
          form_param                = params[form_param_name]
          
          form_param_label          = "formlabel_" + i.to_s
          form_label                = params[form_param_label]
          
          form_param_type_name      = "formparam_type_" + i.to_s
          form_param_type_value     = params[form_param_type_name]
          
          ap form_param_type_name
          ap form_param_type_value
          #sleep 10
          
          input_id = create_input_identifier(input_identifier_counter)
          input_identifier_counter += 1
          
          
          workitem_formparam  = WorkflowItemFormParam.new
          
          workitem_formparam.param_name           = form_param
          workitem_formparam.param_type           = form_param_type_value 
          workitem_formparam.param_label              = form_label
          workitem_formparam.input_identifier     = input_id
          form_params << workitem_formparam
          
          i = i + 1
          
      end
      
      
      
      
      
      
      workflowitem_definition = WorkflowItemDefinition.new
      
      
      workflowitem_definition.name                     = name
      workflowitem_definition.summary                  = summary
      workflowitem_definition.category                 = category
      workflowitem_definition.executable               = executable
      workflowitem_definition.inputs                   = inputs
      workflowitem_definition.outputs                  = outputs
      workflowitem_definition.commandline              = executable
      #workflowitem_definition.optional_form_parameters = Array.new
      workflowitem_definition.form_params              = form_params
      workflowitem_definition.command_format           = command_format
      
      ap "-----"
       ap "name:           " + workflowitem_definition.name
       ap "summary:        " + workflowitem_definition.summary     
       ap "category:       " + workflowitem_definition.category    
       ap "executable:     " + workflowitem_definition.executable  
       ap "inputs:         " + workflowitem_definition.inputs.to_s      
       ap "outputs:        " + workflowitem_definition.outputs.to_s
       ap "CommandLine     " + workflowitem_definition.commandline     
       ap "formparams      " + workflowitem_definition.form_params.to_s
       ap "command_format  " + workflowitem_definition.command_format.to_s
      ap "-----"
      
      
      
      
      tool_saved = save_tool_in_database(workflowitem_definition)
      
      
      if tool_saved == true
        respond_to do |format|
          format.json { render :json => "Added tool successfully".to_json }
        end
      else
        respond_to do |format|
          format.json { render :json => "Could not save tool".to_json }
        end
      end
        
      
  end
  
    
    
    
    def save_tool_in_database(workflowitem_definition)
      
      
        @workflowitem_temp= WorkflowItem.new 
          
        @workflowitem_temp.category       = workflowitem_definition.category
        @workflowitem_temp.isparent       = false
        @workflowitem_temp.itemid         = Time.now.usec
        
        @workflowitem_temp.name           = workflowitem_definition.name
        @workflowitem_temp.parent         = "root"
        
        @workflowitem_temp.summary        = workflowitem_definition.summary
        
        @workflowitem_temp.totalinputs    = workflowitem_definition.inputs.size
        
        @workflowitem_temp.totaloutputs   = workflowitem_definition.outputs.size
        
        @workflowitem_temp.inputs         = workflowitem_definition.inputs
        @workflowitem_temp.outputs        = workflowitem_definition.outputs
        @workflowitem_temp.commandline    = workflowitem_definition.executable
        @workflowitem_temp.command_format = workflowitem_definition.command_format
        
        @workflowitem_temp.formparams     = workflowitem_definition.form_params
          
        begin
          @workflowitem_temp.save!
        rescue
            ap "Exception Occured"
            return false
        end
    
        return true
    end
    
    
  def delete
    ap "The id of the tool being deleted is"
    id = params[:id]
    
    record  = WorkflowItem.find_by_itemid(id)
    name = record.name
    record.destroy
    
    message = "Deleted tool " +name.to_s
    respond_to do |format|
          format.json { render :json => message.to_json}
    end
        
    
    
  end
  
end
