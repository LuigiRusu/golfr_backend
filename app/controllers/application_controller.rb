# Base class for Rails controllers
class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def logged_in!
    return if current_user.present?

    render json: {
      errors: [
        'User not logged in'
      ]
    }, status: :unauthorized
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

  private

  def find_by_id(id)
    user = User.find_by(id: id)

    if user.blank?
      render json: {
        errors: 'The user was not found'
      }, status: :not_found
      return
    end

    user
  end
end
