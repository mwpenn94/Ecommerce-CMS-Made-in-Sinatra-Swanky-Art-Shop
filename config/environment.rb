ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require "active_merchant/billing/rails"

Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

# Send requests to the gateway's test servers
ActiveMerchant::Billing::Base.mode = :test

require_all 'app'