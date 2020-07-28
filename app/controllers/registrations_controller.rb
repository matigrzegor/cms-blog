class RegistrationsController < ApplicationController
    before_action :verify_registration_token, only: :create
    protect_from_forgery except: [:create, :update, :destroy]
    before_action :doorkeeper_authorize!, only: [:update, :destroy]
    before_action :verify_old_password, only: :update

    def create
        build_user

        if @user.save
            destroy_registration_token

            render_successful_registration
        else
            render_bad_request_error
        end
    end

    def update
        load_user
        build_user

        if @user.save
            render_user
        else
            render_bad_request_error
        end 
    end

    def destroy
        load_user

        @user.destroy

        render_successful_deletion
    end

    private

        def build_user
            @user ||= User.new
            @user.attributes = registration_params
        end

        def registration_params
            params.permit(:email, :password, :username)
        end

        def load_user
            @user ||= current_resource_owner
        end

        def token_params
            params[:token]
        end

        def token
            @token ||= token_params
        end

        def old_password_params
            params[:old_password]
        end

        def old_password
            @old_password ||= old_password_params
        end

        def verify_registration_token
            if !RegistrationToken.verify(token)
                render_token_needed_unauthorized_error
            end
        end

        def destroy_registration_token
            RegistrationToken.remove(token)
        end

        def verify_old_password
            load_user

            if PasswordValidator.call(@user, old_password).failure?
                render_bad_old_password_unauthorized_error
            end
        end

        def render_token_needed_unauthorized_error
            render json: UnauthorizedErrorSerializer.new(details: "Registration token needed.").serializable_hash,
                         status: 401
        end

        def render_bad_old_password_unauthorized_error
            render json: UnauthorizedErrorSerializer.new(details: "Bad old password.").serializable_hash,
                         status: 401
        end

        def render_successful_registration
            render json: GeneralSuccessfulActionSerializer.new(action: "Registration").serializable_hash,
                         status: 200
        end

        def render_user
            render json: UserSerializer.new(object: @user).serializable_hash,
                         status: 200
        end

        def render_bad_request_error
            render json: BadRequestErrorSerializer.new(object: @user).serializable_hash,
                         status: 400
        end

        def render_successful_deletion
            render json: GeneralSuccessfulActionSerializer.new(action: "Account deletion").serializable_hash,
                         status: 200
        end
end