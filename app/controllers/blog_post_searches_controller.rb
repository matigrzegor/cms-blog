class BlogPostSearchesController < ApplicationController
  protect_from_forgery except: :create

  def create
    call_blog_post_searcher

    if @blog_post_searcher.success?
      render_successful_blog_post_search
    else
      render_bad_request_error
    end
  end

  private

  def call_blog_post_searcher
    @blog_post_searcher ||= BlogPostSearcher.call(blog_post_search_params)
  end

  def blog_post_search_params
    params.permit(:search, :page)
  end

  def search_result
    @blog_post_searcher.search_result
  end

  def all_search_result_count
    @blog_post_searcher.all_search_result_count
  end

  def error_details
    @blog_post_searcher.error_details
  end

  def render_bad_request_error
    render json: BadRequestErrorSerializer.new(
      details: error_details
    ).serializable_hash, status: 400
  end

  def render_successful_blog_post_search
    render json: BlogPostSerializer.new(
      object: search_result,
      type: :multiple,
      count: all_search_result_count
    ).serializable_hash, status: 200
  end
end
