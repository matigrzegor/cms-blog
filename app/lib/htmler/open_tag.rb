module Htmler
    class OpenTag
        attr_reader :string
        SELF_CLOSING_TAGS = %w(img a)

        def initialize(tag_name, html_class = nil, close_tags_stack)
            if SELF_CLOSING_TAGS.include? tag_name
                @string = "<#{tag_name}#{" class=\"#{html_class}\"" if html_class} ".html_safe
            else 
                @string = "<#{tag_name}#{" class=\"#{html_class}\"" if html_class}>".html_safe
            end
            
            close_tags_stack.add_to_stack(CloseTag.new(tag_name))
        end

        def to_str
            string
        end
    end
end