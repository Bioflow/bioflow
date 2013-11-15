require 'iofiles/file_locator'

class BamFilesList < FileLocator
  
  attr_accessor :list_of_bam_files
  
  def initialize
    #@list_of_bam_files = ["novo_30_sorted.bam", "testLIL.bam", "136.novoalign.sorted.bam", "testLIL_copy.bam", "non_existant.bam"]
    file_locator = FileLocator.new
    @list_of_bam_files = file_locator.locate_files(".bam")
  end
  
  
  def get_bam_files
    return @list_of_bam_files
  end
  
  def get_files
    ap "get_files"
    ap @list_of_bam_files
    return @list_of_bam_files
  end
  
end