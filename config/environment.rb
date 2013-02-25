# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crambear::Application.initialize!

Tilt::CoffeeScriptTemplate.default_bare = true
