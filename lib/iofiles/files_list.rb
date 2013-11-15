class FilesList < FileLocator
  
  def initialize
    file_locator = FileLocator.new
    @list_of_files = file_locator.locate_files(nil)
  end
  
  def get_fasta_files
    return @list_of_files
  end
  def get_files
    return @list_of_files
  end
  
end