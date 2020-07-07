module Quill
    module Chain
        class BaseHandler

            def initialize(next_handler = nil)
                @next_handler = next_handler
            end
        
            def call
                raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
            end
        
            private
        
                attr_reader :next_handler
        
                def failure(arr, details = '')
                    arr[0] = 'error'
                    arr[1] = failure_body(details)

                    return arr
                end
        
                def success(data, arr)
                    arr[0] = 'ok'
                    
                    return arr unless is_next?
                    next_handler.call(data, arr)
                end
        
                def is_next?
                    next_handler
                end

                def failure_body(details)
                    {
                        handler: self.class.name,
                        details: details
                    }
                end
        end
    end
end