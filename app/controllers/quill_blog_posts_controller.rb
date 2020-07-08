class QuillBlogPostsController < ApplicationController
    include ResourceOwnerable
    protect_from_forgery except: :create
    before_action :doorkeeper_authorize!

    def index
        load_quill_blog_posts
        
        render_quill_blog_posts
    end

    def show
        load_quill_blog_post

        render_quill_blog_post
    end

    def create
        build_quill_blog_post

        if build_quill_blog_post.save
            render_quill_blog_post
        else
            render_bad_request_error
        end
    end

    def update
        load_quill_blog_post
        build_quill_blog_post

        if build_quill_blog_post.save
            render_quill_blog_post
        else
            render_bad_request_error
        end
    end

    def destroy
        load_quill_blog_post
        @quill_blog_post.destroy

        render_successful_delete
    end

    private

        def build_quill_blog_post
            @quill_blog_post ||= new_quill_blog_post
            @quill_blog_post.attributes = quill_blog_post_params
            @quill_blog_post
        end

        def new_quill_blog_post
            QuillBlogPost.new(user_id: current_resource_owner_id)
        end

        def load_quill_blog_post
            @quill_blog_post ||= QuillBlogPost.find_by!(user_id: current_resource_owner_id, id: params[:id])
        end

        def load_quill_blog_posts
            @quill_blog_posts ||= QuillBlogPost.where(user_id: current_resource_owner_id)
        end

        def quill_blog_post_params
            params.to_unsafe_h.slice(:title, :introduction, :data)
        end

        def render_quill_blog_post
            render json: QuillBlogPostSerializer.new(object: @quill_blog_post).serializable_hash,
                         status: 200
        end

        def render_quill_blog_posts
            render json: QuillBlogPostSerializer.new(object: @quill_blog_posts, type: :multiple).serializable_hash,
                         status: 200
        end

        def render_successful_delete
            render json: GeneralSuccessfulActionSerializer.new(action: "Blog post deletion").serializable_hash,
                         status: 200
        end

        def render_bad_request_error
            render json: BadRequestErrorSerializer.new(object: @quill_blog_post).serializable_hash,
                         status: 400
        end

end