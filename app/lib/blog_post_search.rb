class BlogPostSearch
    attr_reader :search, :page, :status, :search_result, 
                :error_details, :all_search_result_count

    def self.call(params)
        new(params).call
    end

    def initialize(search: nil, page: nil)
      @search = search
      @page = page
    end
    
    def call
        if valid_params?
            search_through_blog_posts

            @status = true

            self
        else
            @status = false

            self
        end

    rescue => e
        @error_details = e.to_s

        @status = false

        self
    end

    def success?
        status
    end

    private

        def valid_params?
            if search.present? && page.present?
                true
            elsif search.present?
                @error_details = "Page can't be blank"
                false
            else
                @error_details = "Search can't be blank"
                false
            end
        end

        def search_through_blog_posts
            @search_result, @all_search_result_count = BlogPost.textacular_search(search, page)
        end

end