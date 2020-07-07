module Quill
    class UniqueFilenameGenerator
        attr_reader :ordinal_num

        def initialize
          @ordinal_num = 1
        end

        def generate
            filename = generate_filename
            
            increment

            filename
        end

        private

            def increment
                @ordinal_num += 1
            end

            def generate_filename
                Digest::SHA1.hexdigest([Time.now, rand, ordinal_num].join)
            end
    end
end