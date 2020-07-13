module Quill
    module Chain
        class FilesPurgeHandler < BaseHandler

            def call(data, arr = [])
                @data = data

                purge_files

                success(data, arr)
            rescue
                failure(arr)
            end
        
            private

                def quill_blog_post
                    @quill_blog_post ||= @data['quill_blog_post']
                end

                def purge_files
                    quill_blog_post.images.each do |image|
                        image.purge
                    end
                end

        end
    end
end