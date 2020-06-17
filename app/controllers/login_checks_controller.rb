class LoginChecksController < ApplicationController
    protect_from_forgery except: :create

    def create
        user = User.find_for_database_authentication(email: login_check_params[:email)])
      
        if user&.valid_for_authentication? { user.valid_password?(login_check_params[:password]) } && user&.active_for_authentication?
            render json: {status: "OK",
                          code: 200,
                          details: "User found with this credentials"}, status: 200
        else
            render json: {status: "Not found",
                          code: 404,
                          details: "No user found with this credentials"}, status: 404
        end
    end

    private

        def login_check_params
            {
                email: String(params.dig(:user)&.[](:email)),
                password: String(params[:password])
            }
        end
end