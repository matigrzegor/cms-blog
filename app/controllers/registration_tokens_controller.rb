class RegistrationToken < ApplicationController
    protect_from_forgery except: :create

    def create
        token = create_registration_token

        render json: {status: "Registration token successfully craeted.",
                      token: token},
                      status: 200
    end

    private
    
        def create_registration_token
            RegistrationToken.concoct
        end

end