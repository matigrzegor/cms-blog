class RegistrationTokensController < ApplicationController
    protect_from_forgery except: :create
    before_action :doorkeeper_authorize!
    before_action :show_doorkeeper_possibilities

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

        def show_doorkeeper_possibilities
            puts doorkeeper_token
            puts doorkeeper_token.resource_owner_id
        end
end