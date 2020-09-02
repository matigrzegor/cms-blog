class BlogPostAuthorDataUpdater < BaseServiceObject 
  def self.call
    new.call
  end

  def call
    save_blog_posts

    success

    self
  end

  private

  def save_blog_posts
    BlogPost.all.each do |blog_post|
      blog_post.save
    end
  end
end
