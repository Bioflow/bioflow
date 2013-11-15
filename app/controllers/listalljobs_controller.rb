class ListalljobsController < ApplicationController
  
  
  def get_all_jobs

    @jobs = Job.find_all_by_didexecute(true, :order => "id DESC")
    
    rows_per_page = params["rows"].to_i
    current_page  = params["page"].to_i
    total_rows    = @jobs.size

    total_pages = total_rows / rows_per_page
    
    counter = 0

    output=Hash.new
    
    output["page"]  =  current_page
    ap "rpp"
    ap rows_per_page
    ap "cp"
    ap current_page
    ap "total"
    ap total_rows  
    total_pages = 0
    
    if ((total_rows / rows_per_page)%rows_per_page) > 0
      total_pages = ( total_rows / rows_per_page) + 1
    else
      total_pages = ( total_rows / rows_per_page) + 1
    end
    output["records"] = total_rows
    output["total"]   = total_pages
    
    output["rows"]=[]
    
    
    i = ( rows_per_page * current_page) -  rows_per_page
    
    stop = i + rows_per_page 
    
    while(i < stop && i < total_rows)
        
        cur_element = @jobs[i]
        
        i = i + 1
        
        grp = Hash.new
        counter = counter + 1
        grp["id"] = cur_element.id
        grp["cell"] = []
        grp["cell"] << cur_element.job_id
        grp["cell"] << cur_element.created_at
        grp["cell"] << cur_element.jobname
        grp["cell"] << cur_element.status
        output["rows"] << grp
      
      
    end

    return render :json=>output.to_json
    
  end

  #Call for subgrid - Should I remove this or does the client still call this?
  
  def loadjobdetails
    
    
    job_id = params[:jobId]
    
    job_id_xx = job_id.split('_').last
    
    job_outputs = JobOutput.where("job_id = ? ", job_id_xx )
    ap job_outputs
    
    output=[]
    
    for job_output in job_outputs
      
        workitem = job_output.work_output
  
        if  workitem.instance_of? SamToolsSortOutput
                
                sort = SamToolsSort.new
                # needs to be class method
                output_html = sort.get_output_as_html(workitem)
                output << output_html
                
        elsif  workitem.instance_of? WorkflowItemWorkerOutput
          
                worker_output = WorkflowItemWorkerOutput.new
                output_html = worker_output.get_output_as_html(workitem)
                output << output_html
                  
        end
      
      
    end
    
      
    #end
    
    # THIS OUTPUT IS BEING SENT TO CLIENT
    # NEED TO DRAW THIS ON CLIENT SIDE

    puts "Output is"
    puts output.inspect
    
    if output.length == 0
      output << "No output available"
      
    end
    
    return render :json=>output.to_json

    
    
  end

end