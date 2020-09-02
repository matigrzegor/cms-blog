module Htmler
  class CloseTag
    attr_reader :string
    SELF_CLOSING_TAGS = %w(img a)

    def initialize(tag_name)
      if SELF_CLOSING_TAGS.include? tag_name
        @string = " >".html_safe
      else 
        @string = "</#{tag_name}>".html_safe
      end
    end

    def to_str
      string
    end
  end
end
