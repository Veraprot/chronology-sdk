class ApplicationController < ActionController::API
  include Knock::Authenticable
  protect_from_forgery unless: -> { request.format.json? }

  private
  
  def authenticate_v1_user
    authenticate_for V1::User
  end
end
