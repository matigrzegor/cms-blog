module Quill
  class ImageUrlsAdder
    def initialize(quill_blob_post)
      @quill_blob_post = quill_blob_post
    end

    def add
      change_filenames_with_links

      content_in_json
    end

    private

    def image_arr
      @image_arr ||= content_in_json.select { |elem| elem['insert'] != nil && elem['insert']['image'] != nil }
    end

    def content_in_json
      @content_in_json ||= @quill_blob_post.content_in_json
    end

    def change_filenames_with_links
      image_arr.each do |elem|
        image_link = @quill_blob_post.generate_url_from_blob(elem['insert']['image'])

        elem['insert']['image'] = image_link
      end
    end
  end
end
