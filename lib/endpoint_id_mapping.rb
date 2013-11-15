class EndpointIdMapping


  
  
  attr_accessor :ep_to_id_mapping
  
  
  
  def initialize

    @ep_to_id_mapping = Hash.new
    @ep_to_id_mapping["RightMiddle"]  = "output_0"
    @ep_to_id_mapping["TopCenter"]    = "input_0"
    @ep_to_id_mapping["LeftMiddle"]   = "input_1"
    @ep_to_id_mapping["TopLeft"]      = "input_2"
    @ep_to_id_mapping["BottomLeft"]   = "input_3"
  end
  
  def get_mapping
      return ep_to_id_mapping
  end


end