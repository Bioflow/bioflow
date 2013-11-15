class WorkflowItemDefinition

=begin
  
  @name = ""
  @summary = ""
  @category = ""
  
  # Executable with default parameters
  @executable = ""
  
  @inputs = Array.new
  
  @outputs = Array.new
  
  @optional_form_parameters= Array.new
=end 

  attr_accessor :name, :summary, :category, :executable, :inputs, :outputs, :optional_form_parameters, :commandline, :form_params, :command_format

  def initialize 
    @name = ""
    @summary = ""
    @category = ""
    @command_format = "commandformat_1"
    
    @commandline = ""
    
    # Executable with default parameters
    @executable = ""
    
    @inputs = Array.new
    
    @outputs = Array.new
    
    @optional_form_parameters= Array.new
    
    @form_params = ""
  end

  


end