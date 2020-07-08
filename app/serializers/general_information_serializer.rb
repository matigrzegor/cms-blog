class GeneralInformationSerializer
    
    def initialize(details:)
        @details = details
    end

    def serializable_hash
        serializable_hash = {}
        serializable_hash.merge!(base_attributes_hash)
        serializable_hash.merge!(details_attribute_hash)
        serializable_hash
    end

    private

        def base_attributes_hash
            {
                status: "Ok",
                code: 200
            }
        end

        def details_attribute_hash
            {
                details: @details,
            }
        end

end