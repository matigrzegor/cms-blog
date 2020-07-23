class BaseServiceObject
    attr_reader :status, :error_details

    def success?
        status
    end

    def failure?
        !status
    end

    private

        def success
            @status = true
        end

        def failure(details = nil)
            add_error_details(details) if details
            @status = false
        end

        def add_error_details(details)
            @error_details = details
        end

end