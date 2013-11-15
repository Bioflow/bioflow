# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Workflow::Application.initialize!





=begin
YAML.add_domain_type("ActiveRecord,2007", "") do |type, val|
  klass = type.split(':').last.constantize
  YAML.object_maker(klass, val)
end

class ActiveRecord::Base
  def to_yaml_type
    "!ActiveRecord,2007/#{self.class}"  
  end
end

class ActiveRecord::Base
  def to_yaml_properties
    ['@attributes']
  end
end
=end