class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :refresh_taksa
  before_action :reset_notifications
  before_action :home_lajm
  before_action :go_login
  before_action :access
end
