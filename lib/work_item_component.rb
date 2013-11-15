require 'open3'

class WorkItemComponent
  
  
  
  attr_accessor   :work_item_id, :posX, :posTop
  
  def initialize
    @work_item_id
    @posX
    @posTop
  end

  
  
  def get_item_id()
    return @work_item_id
  end

 
 
  def work_item_id=(work_id)
    @work_item_id = work_id
  end

  
  
  def run_the_job(command)

    puts command

=begin
puts "running now"
pid = fork {exec "samtools view"}
puts pid

Process.wait(pid)

puts "Done running now"

=end

    #The :chdir key in options specifies the current directory.
    #sleep 5
    puts "run start ---"
    ap "command is"+command.to_s
   

$stdout.reopen('console.out', 'w')
       $stdout.sync = true
                 $stderr.reopen($stdout)

=begin

Open3.popen3("date") { |stdin, stdout, stderr, wait_thr |
	      puts        "popen3"
                             puts stdout.read
                              puts stderr.read

                                         puts        "done running1"


                                               
#
#
#                                                    # return exit_status.exitstatus, stdout.read, stderr.read
#                                                          #return 0, stdout.read, stderr.read


}


begin
	        sleep 5
		        Open3.popen3("asdfasdasadas") { |stdin, stdout, stderr, wait_thr |


				puts        "popen3"
			puts stdout.read
			          puts stderr.read
				      
				            puts        "done running2"
			}
			  
			    rescue  Exception => e
				            ap "EXCEPTION OCCURED and the exception is "
					            ap e.message
						        end

sleep 5 










=end
     $stdout.reopen('console.out', 'w')
     $stdout.sync = true
     $stderr.reopen($stdout)

	
    @baseDir    = BAM_BASE_DIR['bam_base_dir']
    command = @baseDir +  "/" + command

    Open3.popen3(command) { |stdin, stdout, stderr, wait_thr |
      puts        "popen3"
      #pid         = wait_thr.pid
      #exit_status = wait_thr.value
      #puts        pid
      #puts        exit_status.exitstatus

      
      puts        "done running"


      


     # return exit_status.exitstatus, stdout.read, stderr.read
      return 0, stdout.read, stderr.read
    }
  end
  
  
  def time_diff_in_minutes (start_time, end_time)
    diff_seconds = (end_time - start_time).round
    diff_minutes = diff_seconds / 60
    additional_seconds = diff_seconds - (diff_minutes * 60)
    
    puts "See time below"
    puts start_time.to_s
    puts end_time.to_s
    puts diff_seconds.to_s
    puts diff_minutes.to_s
    puts additional_seconds.to_s
    
    return diff_minutes.to_s + " M  and " + additional_seconds.to_s + " S"
  end

end
