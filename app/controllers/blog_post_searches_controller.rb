class BlogPostSearchesController < ApplicationController
    protect_from_forgery except: :create

    def create
        create_blog_post_search
        
        if @blog_post_search.success?
            render_successful_blog_post_search
        else
            render_bad_request_error
        end
    end

    private

        def create_blog_post_search
            @blog_post_search ||= BlogPostSearch.call(blog_post_search_params)
        end

        def blog_post_search_params
            params.permit(:search, :page)
        end

        def search_result
            @blog_post_search.search_result
        end

        def all_search_result_count
            @blog_post_search.all_search_result_count
        end
        
        def render_bad_request_error
            render json: BadRequestErrorSerializer.new(object: @blog_post_search.error_details).serializable_hash,
                         status: 400
        end

        def render_successful_blog_post_search
            render json: BlogPostSerializer.new(object: search_result, type: :multiple, count: all_search_result_count).serializable_hash,
                         status: 200
        end

end