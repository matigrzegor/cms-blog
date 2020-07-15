class UserProfilesController < ApplicationController
    include ResourceOwnerable
    protect_from_forgery except: [:update]
    before_action :doorkeeper_authorize!, only: [:show, :update]

    def index
        load_users
        
        render_users
    end

    def show
        load_user

        render_user
    end

    def update
        load_user
        build_user

        if @user.save
            #attach_avatar_url
            
            update_user_blog_posts

            render_user
        else
            render_bad_request_error
        end 
    end

    private

        def build_user
            @user.attributes = user_profile_params
        end

        def user_profile_params
            return params.permit(:username, :about, avatar: :data) unless params.dig(:avatar)&.dig(:data).nil?
            params.permit(:username, :about)
        end

        def load_user
            @user ||= current_resource_owner
        end

        def load_users
            @users ||= User.all
        end

        def render_user
            render json: UserSerializer.new(object: @user).serializable_hash,
                         status: 200
        end

        def render_users
            render json: UserSerializer.new(object: @users, type: :multiple).serializable_hash,
                         status: 200
        end

        def render_bad_request_error
            render json: BadRequestErrorSerializer.new(object: @user).serializable_hash,
                         status: 400
        end

        def attach_avatar_url
            @user.attach_avatar_url
        end

        def update_user_blog_posts
            BlogPostAuthorDataUpdater.new(current_resource_owner_id).call
        end

end