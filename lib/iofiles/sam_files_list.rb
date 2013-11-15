class SamFilesList < FileLocator
  
  def initialize
    file_locator = FileLocator.new
    @list_of_sam_files = file_locator.locate_files(".sam")
  end
  
  def get_sam_files
    return @list_of_sam_files
  end
  def get_files
    return @list_of_sam_files
  end
end