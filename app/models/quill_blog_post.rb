class QuillBlogPost < BlogPost
    
    def add_contents
        if validate_data_presence_and_type
        
            data.merge!({'quill_blog_post' => self}) if data
            
            chain_executor = Quill::Chain::Executor.new(data)

            arr = chain_executor.execute

            if arr[0] == 'ok'
                self.attributes = arr[1]
                
                [true]
            elsif arr[0] == 'error'
                error_message = "#{arr[1][:handler]} has failed.#{"Details: #{arr[1][:details]}" if arr[1][:details].present?}"

                [false, error_message]
            end
        else
            [true]
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