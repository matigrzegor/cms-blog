class BadRequestErrorSerializer

    def initialize(active_record_object = nil)
        @active_record_object = active_record_object
    end

    def serializable_hash
        serializable_hash = {}
        serializable_hash.merge!(base_attributes_hash)
        serializable_hash.merge!(details_attribute_hash) if @active_record_object
        serializable_hash
    end

    private

        def base_attributes_hash
            {
                status: "Bad Request",
                code: 400
            }
        end

        def details_attribute_hash
            {
                details: @active_record_object.errors.full_messages.join('. '),
            }
        end

end