class LoginChecksController < ApplicationController
  protect_from_forgery except: :create

  def create
    build_login_check

    if @login_check.save
      render_successful_login_check
    else
      render_bad_request_error
    end
  end

  private

  def build_login_check
    @login_check ||= LoginCheck.new
    @login_check.attributes = login_check_params
  end

  def login_check_params
    {
      email: params.dig(:user)&.[](:email),
      password: params.dig(:password)
    }
  end

  def render_bad_request_error
    render json: BadRequestErrorSerializer.new(
      object: @login_check
    ).serializable_hash, status: 400
  end

  def render_successful_login_check
    render json: GeneralSuccessfulActionSerializer.new(
      action: 'Login check'
    ).serializable_hash, status: 200
  end
end
