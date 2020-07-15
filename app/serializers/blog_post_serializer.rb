class BlogPostSerializer

    def initialize(object: nil, type: :single, count: nil)
        @active_record_object = object
        @type = type
        @count = count
    end

    def serializable_hash
        if @type == :single
            return single_resource_serializable_hash if @active_record_object
            {}
        elsif @type == :multiple
            return multiple_resource_serializable_hash if @active_record_object
            []
        end
    end

    private

        def single_resource_serializable_hash
            base_attributes_hash(@active_record_object).merge!(data_attribute_hash(@active_record_object))
        end

        def multiple_resource_serializable_hash
            blog_posts_arr = @active_record_object.map do |active_record_object|
                base_attributes_hash(active_record_object)
            end

            {
                blog_posts_count: @count,
                blog_posts: blog_posts_arr

            }
        end

        def base_attributes_hash(active_record_object)
            {
                id: active_record_object.id,
                author: active_record_object.author_username,
                author_avatar_url: active_record_object.author_avatar_url,
                create_date: active_record_object.created_at,
                last_update_date: active_record_object.updated_at,
                title: active_record_object.title,
                introduction: active_record_object.introduction
            }
        end

        def data_attribute_hash(active_record_object)
            editor = active_record_object.editor

            {
                data: {
                    editor: editor
                }.merge!(editor_specific_attribute(editor, active_record_object))
            }
        end

        def editor_specific_attribute(editor, active_record_object)
            h = (Kernel.const_get editor).editor_specific_attribute
            h.update(h) { |key, value| value = Quill::JsonImageLinksAdder.new(active_record_object).add }
        end

end