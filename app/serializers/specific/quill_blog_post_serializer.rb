module Specific
    
    class QuillBlogPostSerializer

        def serialize_quill_blog_post(quill_blog_post)
            base_hash(quill_blog_post).merge!(content_hash(quill_blog_post))
        end

        def serialize_quill_blog_posts(quill_blog_posts)
            quill_blog_posts.map do |quill_blog_post|
                base_hash(quill_blog_post)
            end
        end

        private

            def base_hash(quill_blog_post)
                {
                    id: quill_blog_post.id,
                    author: quill_blog_post.author_username,
                    create_date: quill_blog_post.created_at,
                    last_update_date: quill_blog_post.updated_at,
                    title: quill_blog_post.title,
                    introduction: quill_blog_post.introduction
                }
            end

            def content_hash(quill_blog_post)
                {
                    content: quill_blog_post.content_in_json
                }
            end

    end
end