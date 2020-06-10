class RegistrationsController < ApplicationController
    before_action :verify_registration_token, only: :create

    def create
        @user = User.new(sign_up_params)

        if @user.save
            redirect_to root_url
        else
            render :new
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

            redirect_to registration_path unless valid
        end

end