module Quill
  module Chain
    class EditorAttachmentHandler < BaseHandler
      def call(data, arr = [])
        arr[1][:editor] = data['editor']

        success(data, arr)
      end
    end
  end
end
