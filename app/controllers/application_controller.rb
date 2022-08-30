class ApplicationController < ActionController::Base
  include Clearance::Controller

  def sign_in_url
    sign_in_path
  end
end
