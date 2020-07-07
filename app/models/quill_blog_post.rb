class QuillBlogPost < BlogPost
    
    private

        def add_contents
            chain_executor = Quill::Chain::Executor.new(data)

            arr = chain_executor.execute

            if arr[0] == 'ok'
                self.attributes = arr[1]
                
            elsif arr[0] == 'error'
                errors.add(:chain, "#{arr[1][:handler]} has failed.")
                
                throw :abort
            end
        end
end
