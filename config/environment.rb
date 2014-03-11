# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('../../lib/option_watcher',__FILE__)

# Initialize the rails application
StockUtils::Application.initialize!
