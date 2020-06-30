class QuillBlogPost < BlogPost
    
    private

        def content_in_json_structure
            unless content_in_json.dig("editor") == "Quill" && content_in_json.dig("ops")&.is_a?(Array)
                errors.add(:content_in_json, "has invalid structure.")
            end
        end

        def generate_content_in_text
            self.content_in_text = "..."#Quill::TextGenerator.new(ops).generate
        end

        def generate_content_in_html
            self.content_in_html = "<>"#Quill::HtmlGenerator.new(ops).generate
        end

        def add_editor
            self.editor = "Quill"#Quill.name
        end

        def ops
            @ops ||= content_in_json.dig("ops")
        end
    
end

# json = {editor: "Quill", ops: []}
# post = QuillBlogPost.new(title: "cos", introduction: "cos", content_in_json: json)