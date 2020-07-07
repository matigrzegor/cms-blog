class QuillBlogPostsController < ApplicationController
    protect_from_forgery except: :create
    before_action :doorkeeper_authorize!

    def show
        load_quill_blog_post

        render_quill_blog_post
    end

    def index
        render_quill_blog_posts
    end

    def create
        build_quill_blog_post

        if build_quill_blog_post.save
            render_quill_blog_post
        else
            render_error
        end
    end

    def update
        load_quill_blog_post
        build_quill_blog_post

        if build_quill_blog_post.save
            render_quill_blog_post
        else
            render_error
        end
    end

    private

        def build_quill_blog_post
            @quill_blog_post ||= QuillBlogPost.new(user_id: current_resource_owner_id)
            @quill_blog_post.attributes = quill_blog_post_params
            @quill_blog_post
        end

        def load_quill_blog_post
            @quill_blog_post ||= QuillBlogPost.find(params[:id])
        end

        def load_quill_blog_posts
            @quill_blog_posts ||= QuillBlogPost.where(user_id: current_resource_owner_id)
        end

        def quill_blog_post_params
            params.permit(:title, :introduction, data: [:editor, ops: []])
        end

        def render_quill_blog_post
            render json: QuillBlogPostSerializer.new(@quill_blog_post).serializable_hash,
                         status: 200
        end

        def render_quill_blog_posts
            render json: QuillBlogPostSerializer.new(@quill_blog_posts, :multiple).serializable_hash,
                         status: 200
        end

        def render_success
            render json: GeneralSuccessSerializer.new("Registration").serializable_hash,
                         status: 200
        end

        def render_error
            render json: BadRequestErrorSerializer.new(@quill_blog_post).serializable_hash,
                         status: 400
        end

        def current_resource_owner
            @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        end

        def current_resource_owner_id
            @current_resource_owner_id ||= current_resource_owner.id if current_resource_owner
        end
end