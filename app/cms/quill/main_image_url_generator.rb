module Quill
  class MainImageUrlGenerator
    def initialize(quill_blob_post)
      @quill_blob_post = quill_blob_post
    end

    def generate
      generate_main_image_url
    end

    private

    def first_image
      @first_image ||= content_in_json.find { |elem| elem['insert'] != nil && elem['insert']['image'] != nil }
    end

    def content_in_json
      @content_in_json ||= @quill_blob_post.content_in_json
    end

    def generate_main_image_url
      return @quill_blob_post.generate_url_from_blob(first_image['insert']['image']) if first_image

      nil
    end
  end
end
