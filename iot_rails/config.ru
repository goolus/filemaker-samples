# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

#RAILS_RELATIVE_URL_ROOT='/iot_server'
if RAILS_RELATIVE_URL_ROOT then
  map RAILS_RELATIVE_URL_ROOT do
    run Rails.application
  end
else
  run Rails.application
end

