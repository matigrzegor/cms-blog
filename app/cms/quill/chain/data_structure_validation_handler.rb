module Quill
    module Chain
        class DataStructureValidationHandler < BaseHandler

            def call(data, arr = [])
                if data['editor'] == 'Quill' && data['ops'].instance_of?(Array)
                    success(data, arr)
                else
                    failure(arr)
                end
            end
        end
    end
end