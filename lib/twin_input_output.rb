require 'job_output_marker'

class TwinInputOutput < JobOutputMarker
    
    attr_accessor :output1,  :output2
    
    def initialize
      @output1 = ""
      @output2 = ""
      

      
    end

    def get_output_as_html
        puts "GET OUTPUT AS HTML - TWIN INPUT OUTPUT"
                     
    end
end