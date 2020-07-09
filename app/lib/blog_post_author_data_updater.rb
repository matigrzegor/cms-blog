class BlogPostAuthorDataUpdater
    
    def initialize(user_id)
        @user_id = user_id
    end

    def call
        BlogPost.where(user_id: @user_id).each do |blog_post|
            blog_post.save
        end
    end
end