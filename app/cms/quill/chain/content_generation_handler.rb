module Quill
  module Chain
    class ContentGenerationHandler < BaseHandler
      def call(data, arr = [])
        @data, @arr = data, arr

        add_body_hash
        add_content_in_json
        add_content_in_text
        add_content_in_html

        success(data, arr)
      end

      private

      def ops
        @ops ||= @data['ops']
      end

      def add_body_hash
        @arr[1] = {}
      end

      def add_content_in_json
        @arr[1][:content_in_json] = ops
      end

      def add_content_in_text
        @arr[1][:content_in_text] = TextGenerator.new(ops).generate
      end

      def add_content_in_html
        @arr[1][:content_in_html] = "" #HtmlGenerator.new(ops).generate
      end
    end
  end
end
