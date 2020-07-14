module Quill
    module Chain
        class FilesPurgeHandler < BaseHandler

            def call(data, arr = [])
                @data = data

                value = purge_files

                if value[0] == true
                    success(data, arr)
                elsif value[0] == false
                    failure(arr, value[1])
                end
            end
        
            private

                def quill_blog_post
                    @quill_blog_post ||= @data['quill_blog_post']
                end

                def purge_files
                    quill_blog_post.images.each do |image|
                        image.purge_later
                    end
                    [true]
                rescue => err
                    [false, err]
                end

        end
    end
end