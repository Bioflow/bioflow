class FastaFilesList < FileLocator
  
  def initialize
    file_locator = FileLocator.new
    @list_of_fasta_files = file_locator.locate_files(".fasta")
  end
  
  def get_fasta_files
    return @list_of_fasta_files
  end
  def get_files
    return @list_of_fasta_files
  end
  
end