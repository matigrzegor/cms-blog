module Quill
    module Chain
        class Status
            attr_reader :status, :error_details
        
            def initialize(status, error_details = nil)
                @status = status
                @error_details = error_details
            end
        
            def ok?
                return true if status == 'ok'
                false
            end
        
            class << self
        
                def error(error_details)
                    self.new('error', error_details)
                end
        
                def ok
                    self.new('ok')
                end
        
            end
        end
    end
end