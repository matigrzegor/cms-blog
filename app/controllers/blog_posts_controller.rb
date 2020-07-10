class BlogPostsController < ApplicationController

    def index
        load_blog_posts

        respond_with_blog_posts
    end

    def show
        load_blog_post

        respond_with_blog_post
    end

    private

        def load_blog_posts
            @blog_posts ||= BlogPost.page(page_params)
        end

        def load_blog_post
            @blog_post ||= QuillBlogPost.find(params[:id])
        end

        def page_params
            params[:page]
        end

        def respond_with_blog_posts
            respond_to do |format|
                format.json { render_blog_posts }
            end
        end

        def respond_with_blog_post
            respond_to do |format|
                format.json { render_blog_post }
            end
        end

        def render_blog_posts
            render json: BlogPostSerializer.new(object: @blog_posts, type: :multiple).serializable_hash
        end

        def render_blog_post
            render json: BlogPostSerializer.new(object: @blog_post).serializable_hash
        end
        
end