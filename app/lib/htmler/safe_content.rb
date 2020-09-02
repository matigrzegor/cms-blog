module Htmler
  class SafeContent
    attr_reader :string

    def initialize(content)
      @string = content.html_safe
    end

    def to_str
      string
    end
  end
end
