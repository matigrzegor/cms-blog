class QuillBlogPostSerializer

    def initialize(active_record_object, type = :single)
        @active_record_object = active_record_object
        @type = type
    end

    def serializable_hash
        if @type == :single
            single_resource_serializable_hash
        elsif @type == :multiple
            multiple_resource_serializable_hash
        end
    end

    private

        def single_resource_serializable_hash
            base_attributes_hash(@active_record_object).merge!(content_attribute_hash(@active_record_object))
        end

        def multiple_resource_serializable_hash
            @active_record_object.map do |active_record_object|
                base_attributes_hash(active_record_object)
            end
        end

        def base_attributes_hash(active_record_object)
            {
                id: active_record_object.id,
                author: active_record_object.author_username,
                create_date: active_record_object.created_at,
                last_update_date: active_record_object.updated_at,
                title: active_record_object.title,
                introduction: active_record_object.introduction
            }
        end

        def content_attribute_hash(active_record_object)
            {
                content: active_record_object.content_in_json
            }
        end

end
