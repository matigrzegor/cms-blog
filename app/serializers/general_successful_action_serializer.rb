class GeneralSuccessfulActionSerializer
    
    def initialize(action:)
        @action = action
    end

    def serializable_hash
        serializable_hash = {}
        serializable_hash.merge!(message_attribute_hash)
        serializable_hash
    end

    private

        def message_attribute_hash
            {
                message: "#{@action} was successful.",
            }
        end

end