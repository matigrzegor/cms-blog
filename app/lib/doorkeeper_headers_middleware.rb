class DoorkeeperHeadersMiddleware
    
    def initialize(app)
        @app = app
    end

    def call(env)
        @status, @headers, @body = @app.call(env)

        change_redirect_request_to_ok_request_in_doorkeeper_authorization_redirect

        put_env_hash(env)

        [@status, @headers, @body]
    end

    private

        def change_redirect_request_to_ok_request_in_doorkeeper_authorization_redirect
            if @status == 302
                @status = 200
                #@body = ActionDispatch::Response::RackBody.new(location_hash.to_json)
                @body = [location_hash.to_json]
                @headers['Content-Type'] = "application/json"
            end
        end

        def location_hash
            {
                location: @headers['Location']
            }
        end

        def put_env_hash(env)
            env.each do |k,v|
                puts '#' * 40
                puts "#{k}:   #{v}"
            end

            puts '#' * 40
            puts "status:   #{@status}"
            puts '#' * 40
            puts "headers:   #{@headers}"
            puts '#' * 40 
            puts "body:   #{@body}"
            puts '#' * 40 
        end
end