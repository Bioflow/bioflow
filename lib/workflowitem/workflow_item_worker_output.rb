require 'htmlentities'
require 'job_output_marker'


class WorkflowItemWorkerOutput < JobOutputMarker
  
  
    attr_accessor :output,  :stdout, :stderr, :exit_code, :name, :inputs, :outputs, :time_start, :time_end, :total_time, :job_id, :status, :command_line
  
    
    def initialize
      @output     = ""
      @stdout     = ""
      @stderr     = ""
      @exit_code  = -100

      puts ""
      puts ""
      puts ""
      puts ""
      puts "Inside INTIIALISE in GENERIC output"
      puts "" 
      puts ""
      puts ""
     

    end

    def get_output_as_html(output)
      
      coder = HTMLEntities.new
      ap output
      
      #sleep 2
      outputs = output.outputs
      
      time_start_str = ""
      if output.time_start != nil
        time_start_str = output.time_start.strftime("%b %e, %l:%M %p")
      end
      
      
         html_str =    "<div class=\"output-header\" >" \
                     +  output.name  \
                     +  "</div>" \
                     +    "<table class= \"output-table-style\" ><col width=\"140px\" />" 
                     
                     for out in outputs
                       ap "---------"
                       ap  out.output_file_name
        html_str = html_str  + "<tr>"   \
                     +  "<td class=\"output-table-cell-left\">" \
                     +        "Output file "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        ((out.output_file_name.nil? || out.output_file_name.length == 0) ? " -- None -- ": out.output_file_name)   \
                     +    "</td>"   \
                     +  "</tr>"   
                     end
                     for out in output.inputs
        html_str = html_str  + "<tr>"   \
                     +  "<td class=\"output-table-cell-left\">" \
                     +        "Input file "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +     ((out.input_value.nil? ) ? "--None--" : out.input_value.to_s )  \
                     +    "</td>"   \
                     +  "</tr>"   
                     end
        html_str = html_str  + "<tr>"   \
                     +  "</tr>"   \
                     +  "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Status "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        output.status   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Stdout "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +        coder.encode(output.stdout)   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td  class=\"output-table-cell-left\">"   \
                     +        "Stderr "   \
                     +    "</td>"   \
                     +    "<td class=\"output-table-cell-right\">"   \
                     +         coder.encode(output.stderr)   \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td class=\"output-table-cell-left\">"   \
                     +        "exit_code "   \
                     +    "</td>"   \
                     +    "<td>"   \
                     +       output.exit_code.to_s \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td class=\"output-table-cell-left\">"   \
                     +        "TimeStart "   \
                     +    "</td>"   \
                     +    "<td>"   \
                     +        time_start_str \
                     +    "</td>"   \
                     +  "</tr>"   \
                     + "<tr>"   \
                     +    "<td class=\"output-table-cell-left\">"   \
                     +        "Time Taken "   \
                     +    "</td>"   \
                     +    "<td>"   
                            if output.total_time.nil?
                     html_str = html_str  +      ""         
                            else
                     html_str = html_str  +         output.total_time
                            end 
                     html_str = html_str  +    "</td>"   \
                     +  "</tr>"   \
                     + "</table>"   
                     #.to_s   
        return html_str
                     
    end
  
  
  
  
  
end