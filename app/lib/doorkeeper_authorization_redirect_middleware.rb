class DoorkeeperAuthorizationRedirectMiddleware
    
    def initialize(app)
        @app = app
    end

    def call(env)
        @status, @headers, @body = @app.call(env)

        if is_doorkeeper_authorization_redirect?(env)
            change_redirect_request_to_ok_request
        end

        [@status, @headers, @body]
    end

    private

        def change_redirect_request_to_ok_request
            @status = 200
            @body = [location_hash.to_json]
            @headers['Content-Type'] = "application/json"
        end

        def is_doorkeeper_authorization_redirect?(env)
            if @status == 302 && env['REQUEST_PATH'] == "/oauth/authorize"
                true
            else
                false
            end
        end

        def location_hash
            {
                location: @headers['Location']
            }
        end
        
end