class BlogPostAuthorDataUpdater
    attr_reader :status, :error_details

    def self.call
        new.call
    end
    
    def call
        save_blog_posts

        self
    end

    def success?
        status
    end

    private

        def save_blog_posts
            BlogPost.all.each do |blog_post|
                blog_post.save
            end

            @status = true
        end
end