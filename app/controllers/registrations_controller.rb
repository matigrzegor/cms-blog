class RegistrationsController < ApplicationController
    before_action :verify_registration_token, only: :create
    protect_from_forgery except: :create

    def create
        build_user

        if @user.save
            destroy_registration_token
            render json: {status: "Registration was successful."},
                          status: 200
        else
            render json: {status: "Bad Request",
                          code: 400,
                          details: @user.errors.full_messages.join('. ')},
                          status: 400
        end
    end

    private

        def build_user
            @user ||= User.new
            @user.attributes = registration_params
        end

        def registration_params
            {
                email: String(params[:email]),
                password: String(params[:password]),
                username: String(params[:username])
            }
        end

        def registration_token_params
            String(params[:token])
        end

        def registration_token
            @registration_token ||= registration_token_params
        end

        def verify_registration_token
            valid = RegistrationToken.verify(registration_token)

            render json: {status: "Forbidden",
                          code: 403,
                          details: "Registration token needed."},
                          status: 403 unless valid
        end

        def destroy_registration_token
            RegistrationToken.remove(registration_token)
        end
end