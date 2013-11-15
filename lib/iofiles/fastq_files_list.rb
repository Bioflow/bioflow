class FastqFilesList < FileLocator
  
  def initialize
    file_locator = FileLocator.new
    @list_of_fastq_files = file_locator.locate_files(".fastq")
  end
  
  def get_fastq_files
    return @list_of_fastq_files
  end
  
  def get_files
    return @list_of_fastq_files
  end
end