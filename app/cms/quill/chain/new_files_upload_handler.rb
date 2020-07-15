module Quill
    module Chain
        class NewFilesUploadHandler < BaseHandler

            def call(data, arr = [])
                @data = data
                
                value = upload_new_files_and_change_image_inserts_with_unique_filenames

                if value[0] == true
                    success(data, arr)
                elsif value[0] == false
                    failure(arr, value[1])
                end
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

                def upload_new_files_and_change_image_inserts_with_unique_filenames
                    image_arr.each do |elem|  
                        image = elem['insert']['image']
                        
                        if image[0..21] == "data:image/jpeg;base64" || image[0..20] == "data:image/png;base64"
                            unique_filename = generate_unique_filename

                            quill_blog_post.images.attach({
                                data: image,
                                filename: unique_filename
                            })

                            image = unique_filename

                        elsif image.split('/')[0..2].join == domain_name
                            unique_filename = image.split('/')[-1].split('?')[0]

                            image = unique_filename
                        end
                    end
                    [true]
                rescue => err
                    [false, err]
                end
    
                def generate_unique_filename
                    unique_filename_generator.generate
                end
    
                def unique_filename_generator
                    @unique_filename_generator ||= UniqueFilenameGenerator.new
                end

                def domain_name
                    ENV['DOMAIN_NAME']
                end
        end
    end
end