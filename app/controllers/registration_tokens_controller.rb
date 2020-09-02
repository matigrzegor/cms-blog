class RegistrationTokensController < ApplicationController
  protect_from_forgery except: :create
  before_action :doorkeeper_authorize!

  def create
    build_registration_token

    @registration_token.save

    render_registration_token
  end

  private

  def build_registration_token
    @registration_token = RegistrationToken.new
  end

  def render_registration_token
    render json: RegistrationTokenSerializer.new(
      object: @registration_token
    ).serializable_hash, status: 200
  end
end
