class RegistrationsController < ApplicationController
    before_action :verify_registration_token, only: :create

    def create
        @user = User.new(sign_up_params)

        if @user.save
            destroy_registration_token
            render json: {status: "Registration was successful."}, status: 200
        else
            render json: {status: "Bad Request",
                          code: 400,
                          details: @user.errors.full_messages.join('. ')}, status: 400
        end
    end

    private

        def sign_up_params
            {
                email: String(params[:email]),
                password: String(params[:password]),
                username: String(params[:username])
            }
        end

        def token_from_params
            String(params[:token])
        end

        def token
            @token ||= token_from_params
        end

        def verify_registration_token
            valid = RegistrationToken.verify(@token)

            render json: {status: "Forbidden",
                          code: 403,
                          details: "Registration token needed."}, status: 403
        end

        def destroy_registration_token
            RegistrationToken.remove(@token)
        end
end