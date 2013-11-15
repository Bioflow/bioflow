class FormHandler
  
  
  
  
  
  def initialize
    
  end
  
  
  def process_form(parameters, work_flow_objects, job_id)
  
  
    ap "Submitted parameters are"
    ap parameters
    
    form_id = parameters[:formId]
    
    if form_id.start_with?('input_bamfile')
      return process_bamfile(parameters, work_flow_objects)
    elsif
       form_id.start_with?('samtools_sort')
       return process_samfilesort(parameters, work_flow_objects)
    elsif
       form_id.start_with?('job_name')
       return edit_job_details(parameters, job_id)
    else
      return process_generic_params(parameters, work_flow_objects)
    end 
    
    
    return "no matching stuff foud"
  end

  def process_generic_params(parameters, work_flow_objects)
  
    output           = Hash.new
    output['status'] = "Success"
    
    generic_param    = parameters[:some_thing_goes_here]
    
    form_id          = parameters[:formId]
    #This is of the type
    # "input_bamfile__widget3"
    #Convert it to the form
    # "input_bamfile_widget3"
    
    ap "object id is"
    obj_id           = form_id.gsub("__", "_")
    ap obj_id

    ap "workflow objects"
    generic_obj      = work_flow_objects[obj_id]

    ap "BEFORE -------"
    ap generic_obj
    
    
    for param in parameters
       ap param
      
       if param[0] != "formId" && param[0] != "controller" && param[0] != "action"
          # I am interested in this param
          #ap "Interested in"
          #ap param[0]
          #ap param[1] 
          generic_obj.set_input_param(param[0], param[1])
        
       end
    end
   
    ap "AFTER --------"
    ap generic_obj
    
    
    output['message'] = generic_obj.name + " - parameters saved successfully"
    return output
  end
  
  
  
  

  def edit_job_details(parameters, job_id)
      
      output = Hash.new
      output['status'] = "Success"
      
      job_name = parameters[:job_name]
      
      job = Job.find_by_job_id(job_id)
      
      job.jobname = job_name
      
      begin
      
      job.save!
      
      rescue Exception => e
          ap e.class
          ap e
          ap e.message
          output['status']  = "Failure"
          output['message'] = e.message
          return output
      end
      
      output['message'] = "Job name changed successfully"
      output['new_name'] = job_name
      return output
  end
  
  
=begin
 May be there should be seperate class for processing
 each form's parameters. Then I can use inheritance and just
 call super_clas_obj.process_parameters()
 But for now, Ill  write seperate methods for each one
=end
  def process_bamfile(parameters, work_flow_objects)
  
    output = Hash.new
    output['status'] = "Success"
    
    new_bam_file = parameters[:bamfile]
     
    
    form_id = parameters[:formId]
    #This is of the type
    # "input_bamfile__widget3"
    #Convert it to the form
    # "input_bamfile_widget3"
    
    ap "object id is"
    obj_id = form_id.gsub("__", "_")

    ap obj_id
    ap "workflow objects"
    ap work_flow_objects
    bam_file_obj = work_flow_objects[obj_id]

    bam_file_obj.bamFileName=(new_bam_file)
    puts "inspect here-"+bam_file_obj.inspect
    
    output['message'] = "Bam File's parameters saved successfully"
    return output
  end
  
  
  
   def process_samfilesort(parameters, work_flow_objects)
    
     output = Hash.new
     output['status'] = "Success"
      
     new_sort_on         = parameters[:on]
     new_sort_mem        = parameters[:m]
     new_sort_outputfile = parameters[:outputfile]
     
    
    form_id = parameters[:formId]
    #This is of the type
    # "input_bamfile__widget3"
    #Convert it to the form
    # "input_bamfile_widget3"
    obj_id = form_id.gsub("__", "_")
    

    samfilesort_obj = work_flow_objects[obj_id]

    #puts "inspect here-"+samfilesort_obj.inspect
    samfilesort_obj.sort_on=(new_sort_on)
    samfilesort_obj.sort_mem=(new_sort_mem)
    samfilesort_obj.sort_outputfile=(new_sort_outputfile)
    puts "inspect here-"+samfilesort_obj.inspect
    
    output['message'] = "Samtools params saved successfully"
    return output


  end
  
end