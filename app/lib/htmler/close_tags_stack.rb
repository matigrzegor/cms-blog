module Htmler
  class CloseTagsStack
    attr_reader :stack

    def initialize
      @stack = []
    end

    def add_to_stack(close_tag)
      @stack.push close_tag
    end

    def get_from_stack
      @stack.pop
    end
  end
end
