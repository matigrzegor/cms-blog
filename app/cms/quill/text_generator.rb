module Quill
  class TextGenerator
    attr_reader :ops_arr

    def initialize(ops_arr)
      @ops_arr = ops_arr
    end

    def generate
      ops_arr.select { |e| e["insert"] != "\n" && e["insert"].instance_of?(String) }.map { |e| e["insert"] }.join
    end
  end
end
