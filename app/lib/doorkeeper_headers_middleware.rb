class DoorkeeperHeadersMiddleware
    
    def initialize(app)
        @app = app
    end

    def call(env)
        @status, @headers, @body = @app.call(env)

        add_access_control_allow_origin_header

        [@status, @headers, @body]
    end

    private

        def add_access_control_allow_origin_header
            if @status == 302
                @headers["Access-Control-Allow-Origin"] = 'https://musing-ramanujan-8002a4.netlify.app'
            end
        end
end