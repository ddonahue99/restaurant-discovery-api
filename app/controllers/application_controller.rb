class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :check_auth

  def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_email(username)
      render json: {error: "Not authorized."}.to_json, status: 401 unless resource
      
      if resource.valid_password?(password)
        sign_in :user, resource
      end
    end
  end
end
