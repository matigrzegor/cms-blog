module Htmler
    class Block
        attr_reader :string

        def initialize
            @string = "".html_safe
        end 

        def to_str
            string
        end

        def <<(object)
            to_str << object.to_str
            self
        end
    end
end