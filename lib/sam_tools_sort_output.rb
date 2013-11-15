require 'job_output_marker'

class SamToolsSortOutput < JobOutputMarker

    attr_accessor :output_file_name,  :output_file_dir, :stdout, :stderr, :exit_code, :input_file_name
    
    def initialize
      @input_file_name = ""
      @output_file_name = ""
      @output_file_dir  = ""
      @stdout = ""
      @stderr = ""
      @exit_code = -100

      puts ""
      puts ""
      puts ""
      puts ""
      puts "Inside INTIIALISE in sam tools sort output"
      puts "" 
      puts ""
      puts ""
     

    end

    def get_output_as_html
        puts "GET OUTPUT AS HTML - SAMTOOLS SORT OUTPUT"
                     
    end
  end