class GeneralSuccessSerializer
    
    def initialize(action)
        @action = action
    end

    def serializable_hash
        serializable_hash = {}
        serializable_hash.merge!(status_attribute_hash)
        serializable_hash
    end

    private

        def status_attribute_hash
            {
                status: "#{@action} was successful.",
            }
        end

end