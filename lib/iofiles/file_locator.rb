class FileLocator
  
  
  def locate_files(filetype)
    
    
    @baseDir = BAM_BASE_DIR['bam_base_dir']
    file_list = Array.new
    
    ap "Inside file locator"
    ap @baseDir
    
    
    Dir.foreach(@baseDir) do |item|
        
        if item=="." || item == ".."
          #IGNORE  
        else
            if filetype.nil?
              file_list << item
            elsif item.end_with?(filetype)
              file_list << item
            end
        end
    
        
    end
    return file_list
  end
  
  
end