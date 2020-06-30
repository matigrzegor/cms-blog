class BlogPost < ApplicationRecord
    before_save :generate_content_in_text
    before_save :generate_content_in_html
    before_save :add_editor
    
    validates_presence_of :title, :introduction, :type, :content_in_json
    
    validates :introduction, length: { maximum: 200 }
    validates :title, length: { maximum: 200 }

    validate :content_in_json_structure, if: :content_in_json_valid_format?

    def content_in_json=(value)
        value = JSON.generate(value)
        super(value)
    end

    def content_in_json
        JSON.parse(super) unless super.nil?
    end

    private

        def content_in_json_valid_format?
            if content_in_json.blank?
                false
            elsif !(content_in_json.is_a?(Hash))
                errors.add(:content_in_json, "has invalid format.")
                false
            else
                true
            end
        end

        def content_in_json_structure
            raise NotImplementedError, "#{self.class} has not implemented validation method '#{__method__}'"
        end

        def generate_content_in_text
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        def generate_content_in_html
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        def add_editor
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end
end
