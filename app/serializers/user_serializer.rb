class UserSerializer

    def initialize(object: nil, type: :single)
        @active_record_object = object
        @type = type
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
            base_attributes_hash(@active_record_object)
        end

        def multiple_resource_serializable_hash
            @active_record_object.map do |active_record_object|
                base_attributes_hash(active_record_object)
            end
        end

        def base_attributes_hash(active_record_object)
            {
                username: active_record_object.username,
                email: active_record_object.email,
                avatar_url: active_record_object.avatar_url,
                about: active_record_object.about
            }
        end

end