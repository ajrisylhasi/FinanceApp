# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.config.assets.precompile += %w( Chart.bundle.js )

Rails.application.initialize!

require 'carrierwave/orm/activerecord'