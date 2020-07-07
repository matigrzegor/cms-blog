module Quill
    module Chain
        class DataJsonificationHandler < BaseHandler

            def call(data, arr = [])
                data = jsonify(data)

                success(data, arr)
            end

            private

                def jsonify(data)
                    JSON.parse(JSON.generate(data))
                end
        end
    end
end