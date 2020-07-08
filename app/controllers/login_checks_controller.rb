class LoginChecksController < ApplicationController
    protect_from_forgery except: :create

    def create
        user = User.find_for_database_authentication(email: login_check_params[:email])
      
        if user == nil
            render_wrong_email_error
        elsif user&.valid_for_authentication? { user.valid_password?(login_check_params[:password]) } && user&.active_for_authentication?
            render_success
        else
            render_wrong_password_error
        end
    end

    private

        def login_check_params
            {
                email: String(params.dig(:user)&.[](:email)),
                password: String(params[:password])
            }
        end

        def render_wrong_email_error
            render json: BadRequestErrorSerializer.new(details: "No user found with this email.").serializable_hash,
                         status: 400
        end

        def render_wrong_password_error
            render json: BadRequestErrorSerializer.new(details: "Wrong password for this email.").serializable_hash,
                         status: 400
        end

        def render_success
            render json: {status: "OK",
                          code: 200,
                          details: "User found with this credentials"}, status: 200
        end
end