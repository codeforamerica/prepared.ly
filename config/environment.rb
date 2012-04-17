# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Preparedly::Application.initialize!

#takes ca-bundle.crt file that was created from file on https://www.digicert.com/digicert-root-certificates.htm 
OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"