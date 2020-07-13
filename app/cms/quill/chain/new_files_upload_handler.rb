module Quill
    module Chain
        class NewFilesUploadHandler < BaseHandler

            def call(data, arr = [])
                @data = data
                
                upload_new_files_and_change_base64_with_links_in_data
                
                success(data, arr)
            rescue => err
                failure(arr, err)
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

                def upload_new_files_and_change_base64_with_links_in_data
                    image_arr.each do |elem|  
                        
                        quill_blog_post.images.attach({
                            #data: elem['insert']['image']
                            data: elem.require(:insert).permit(:image)
                        })

                        image_url = quill_blog_post.last_image_url

                        elem['insert']['image'] = image_url

                    end
                end
    
                #def generate_unique_filename
                #    unique_filename_generator.generate
                #end
    
                #def unique_filename_generator
                #    @unique_filename_generator ||= UniqueFilenameGenerator.new
                #end

        end
    end
end