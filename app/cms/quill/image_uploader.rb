module Quill
    class ImageUploader
        attr_reader :ops_arr, :quill_blog_post

        def initialize(ops_arr, quill_blog_post)
            @ops_arr = ops_arr
            @quill_blog_post = quill_blog_post
        end

        def upload
            find_used_files

            purge_unused_files

            upload_new_files_and_add_new_links
        end

        private

            def files_in_use
                @files_in_use ||= []
            end

            def find_used_files
                image_arr.each do |elem|
                   
                    if elem[:insert][:image][0..26] == "/rails/active_storage/blobs/"
                        files_in_use << elem[:insert][:image].split('?')[0].split('/')[-1]
                    end
                end
            end

            def purge_unused_files
                all_files = []
                
                quill_blog_post.images.each do |e|
                    all_files << e.filename.to_s
                end

                unused_files = all_files - files_in_use

                purge_files(unused_files)
            end

            def upload_new_files_and_add_new_links
                image_arr.each do |elem|
                    
                    if elem[:insert][:image][0..9] == "data:image"
                        
                        quill_blog_post.images.attach({
                            data: elem[:insert][:image],
                            filename: generate_unique_filename
                        })

                        image_url = quill_blog_post.last_image_url

                        elem[:insert][:image] = image_url
                    end
                end
            end

            def generate_unique_filename
                unique_filename_generator.generate
            end

            def unique_filename_generator
                @unique_filename_generator ||= UniqueFilenameGenerator.new
            end

            def image_arr
                @image_arr ||= ops_arr.select {|elem| elem[:insert] != nil && elem[:insert][:image] != nil}
            end

            def purge_files(filenames)
                filenames.each do |filename|
                    #ActiveStorage::Blob.find_by(filename: filename).purge
                end
            end

    end
end