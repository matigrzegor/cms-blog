module ContentStorable

    def content_in_json=(value)
        value = JSON.generate(value)
        super(value)
    end

    def content_in_json
        JSON.parse(super) unless super.nil?
    end

    def content_in_text=(value)
        value = String(value)
        super(value)
    end

    def content_in_html=(value)
        value = String(value)
        super(value)
    end

end