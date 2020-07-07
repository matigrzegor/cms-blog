module Quill
    class HtmlGenerator
        attr_reader :ops_arr

        def initialize(ops_arr)
            @ops_arr = ops_arr
        end

        def generate
            html_block = new_html_block
            
            ops_arr.each do |elem|

                if elem['insert'] != "\n" && !elem['insert'].instance_of?(Hash) && elem['attributes'] == nil
                    
                    html_block << elem['insert']

                elsif elem['insert'] != "\n" && elem['insert'].instance_of?(Hash) && elem['attributes'] == nil
                
                    html_block << img_tag_with_image_link(elem)

                elsif elem['insert'] != "\n" && elem['attributes'] != nil
                    
                    html_block << span_tag_with_insert(elem)

                elsif (elem['insert'] == "\n" && elem['attributes'] == nil) || 
                        (elem['insert'] == "\n" && elem['attributes'] != nil && elem['attributes']['header'] == nil)
                    
                    html_body << p_tag_with_html_block(html_block)
                    
                    html_block = new_html_block

                elsif elem['insert'] == "\n" && elem['attributes'] != nil && elem['attributes']['header'] != nil
                    
                    html_body << h_tag_with_html_block(elem, html_block)
                    
                    html_block = new_html_block

                end
            end
            
            html_body.to_str
        end

        private

            def new_html_block
                Htmler::Block.new
            end

            def html_body
                @html_body ||= Htmler::Block.new
            end

            def safe_content(content)
                Htmler::SafeContent.new(content)
            end

            def img_tag_with_image_link(elem)
                new_html_block << open_tag('img') << "src=" << safe_content("\"#{elem['insert']['image']}\"") << close_tag
            end

            def span_tag_with_insert(elem)
                html_class = elem['attributes'].map do |k, v|
                    k if k == "bold" || k == "underline" || k == "italic"
                end.compact.map { |style| "article--style-#{style} " }.join.strip!
                
                new_html_block << open_tag('span', html_class) << elem['insert'] << close_tag
            end

            def p_tag_with_html_block(html_block)
                new_html_block << open_tag('p') << html_block << close_tag
            end

            def h_tag_with_html_block(elem, html_block)
                tag_name = "h#{elem['attributes']['header']}"
                    
                new_html_block << open_tag(tag_name) << html_block << close_tag
            end

            def close_tags_stack
                @close_tags_stack ||= Htmler::CloseTagsStack.new
            end

            def open_tag(tag_name, html_class = nil)
                Htmler::OpenTag.new(tag_name, html_class, close_tags_stack)
            end

            def close_tag
                close_tags_stack.get_from_stack
            end

    end
end