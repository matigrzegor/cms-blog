class BlogPostsController < ApplicationController

    def index
        load_blog_posts

        render_blog_posts
    end

    def show
        load_blog_post

        render_blog_post
    end

    private

        def load_blog_posts
            @blog_posts ||= BlogPost.page(page_params)
        end

        def load_blog_post
            @blog_post ||= BlogPost.find(params[:id])
        end

        # /blog_posts?page=3
        def page_params
            puts params[:page]
            params[:page]
        end

        def blog_posts_count
            BlogPost.count
        end

        def render_blog_posts
            render json: BlogPostSerializer.new(object: @blog_posts, type: :multiple, count: blog_posts_count).serializable_hash,
                         status: 200
        end

        def render_blog_post
            render json: BlogPostSerializer.new(object: @blog_post).serializable_hash,
                         status: 200
        end
        
end