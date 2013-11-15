class GzippedFilesList < FileLocator
  
  def initialize
    file_locator = FileLocator.new
    @list_of_gzipped_files = file_locator.locate_files(".gz")
  end
  
  def get_gzipped_files
    return @list_of_gzipped_files
  end
  
  def get_files
    return @list_of_gzipped_files
  end
end