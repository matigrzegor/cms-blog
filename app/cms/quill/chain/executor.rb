module Quill
    module Chain
        class Executor

            def initialize(data)
                @data = data
                @chain = first_handler.new(second_handler.new(third_handler.new(fourth_handler.new(fifth_handler.new(sixth_handler.new)))))    
            end

            def execute
                @chain.call @data
            end

            private

                def first_handler
                    Chain::DataStructureValidationHandler
                end

                def second_handler
                    Chain::UnusedFilesPurgeHandler
                end

                def third_handler
                    Chain::NewFilesUploadHandler
                end

                def fourth_handler
                    Chain::DataJsonificationHandler
                end

                def fifth_handler
                    Chain::ContentGenerationHandler
                end

                def sixth_handler
                    Chain::EditorAttachmentHandler
                end
        end
    end
end