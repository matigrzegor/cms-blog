module Quill
    module Chain
        class FirstImageAttachmentHandler < BaseHandler

            def call(data, arr = [])
                @data = data
                
                
                
                success(data, arr)
            rescue
                failure(arr)
            end

            private

                def ops
                    @ops ||= @data['ops']
                end

                def image_arr
                    @image_arr ||= ops.select {|elem| elem['insert'] != nil && elem['insert']['image'] != nil}
                end

                def quill_blog_post
                    @quill_blog_post ||= @data['quill_blog_post']
                end

        end
    end
end