class QuillBlogPost < BlogPost
    
    private

        def add_contents
            data.merge!({'quill_blog_post' => self}) if data
            
            chain_executor = Quill::Chain::Executor.new(data)

            arr = chain_executor.execute

            if arr[0] == 'ok'
                self.attributes = arr[1]
                
            elsif arr[0] == 'error'
                errors.add(:chain, "#{arr[1][:handler]} has failed.#{"Details: #{arr[1][:details]}" if arr[1][:details].present?}")
                
                throw :abort
            end
        end
end

################################
#
# 'data' => {
#     'editor' => 'Quill',
#     'ops' => [],
#     'quill_blog_post' => quill_blog_post_object
# }