class DoorkeeperAuthorizationRedirectMiddleware
    
    def initialize(app)
        @app = app
    end

    def call(env)
        @status, @headers, @body = @app.call(env)

        if is_doorkeeper_authorization_redirect?(env)
            change_redirect_response_to_ok_response(env)
        end

        [@status, @headers, @body]
    end

    private

        def change_redirect_response_to_ok_response(env)
            if env['REQUEST_METHOD'] == "POST"
                set_grant_values
            elsif env['REQUEST_METHOD'] == "DELETE"
                set_deny_values
            end
        end

        def is_doorkeeper_authorization_redirect?(env)
            @status == 302 && env['REQUEST_PATH'] == "/oauth/authorize"
        end

        def set_grant_values
            @status = 200
            @body = [grant_location_hash.to_json]
            @headers['Content-Type'] = "application/json"
        end

        def set_deny_values
            @status = 200
            @body = [deny_location_hash.to_json]
            @headers['Content-Type'] = "application/json"
        end

        def grant_location_hash
            location = @headers['Location']

            location_hash(location)
        end

        def deny_location_hash
            location = @headers['Location'].split('?')[0].split('//').map { |e| e.split('/')[0] }.join('//')

            location_hash(location)
        end

        def location_hash(location)
            {
                location: location
            }
        end
        
end