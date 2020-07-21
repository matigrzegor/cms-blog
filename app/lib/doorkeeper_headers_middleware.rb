class DoorkeeperHeadersMiddleware
    
    def initialize(app)
        @app = app
    end

    def call(env)
        @status, @headers, @body = @app.call(env)

        change_redirect_status_to_ok_status_in_doorkeeper_authorization_redirect

        add_location_header_to_body

        add_content_type_header

        put_env_hash(env)

        [@status, @headers, @body]
    end

    private

        def change_redirect_status_to_ok_status_in_doorkeeper_authorization_redirect
            if @status == 302
                @status = 200
            end
        end

        def add_location_header_to_body
            #@body = ActionDispatch::Response::RackBody.new(location_hash.to_json)
            @body = location_hash.to_json
        end

        def add_content_type_header
            @headers['Content-Type'] = "application/json"
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