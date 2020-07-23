class BlogPostSearcher < BaseServiceObject
    attr_reader :search, :page, :search_result, :all_search_result_count

    def self.call(params)
        new(params[:search], params[:page]).call
    end


    def initialize(search = nil, page = nil)
        @search = search
        @page = page
    end
    
    def call
        valid, details = validate_params
        
        if valid
            search_through_blog_posts

            success

            self
        else
            failure(details)

            self
        end
    end

    private

        def validate_params
            if search.present? && page.present?
                Integer(page)
                [true]
            elsif search.present?
                [false, "Page can't be blank."]
            elsif page.present?
                [false, "Search can't be blank."]
            else 
                [false, "Page can't be blank. Search can't be blank."]
            end
        rescue
            [false, "Page must be a number."]
        end

        def search_through_blog_posts
            @search_result, @all_search_result_count = BlogPost.textacular_search(search, page)
        end

end