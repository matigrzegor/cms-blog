class UnauthorizedErrorSerializer
    
    def initialize(details: nil)
        @details = details
    end

    def serializable_hash
        serializable_hash = {}
        serializable_hash.merge!(base_attributes_hash)
        serializable_hash.merge!(details_attribute_hash) if @details
        serializable_hash
    end

    private

        def base_attributes_hash
            {
                status: "Unauthorized",
                code: 401
            }
        end

        def details_attribute_hash
            {
                details: @details,
            }
        end
end