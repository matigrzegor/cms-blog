class RegistrationsController < ApplicationController
    before_action :verify_registration_token, only: :create

    def create
        @user = User.new(sign_up_params)

        if @user.save
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

        def verify_registration_token
            token = String(params[:token])
            valid = RegistrationToken.verify(token)

            render json: {status: "Forbidden",
                          code: 403,
                          details: "Registration token needed."}, status: 403
        end

end