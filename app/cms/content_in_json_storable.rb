module ContentInJsonStorable

    def content_in_json=(value)
        value = JSON.generate(value)
        super(value)
    end

    def content_in_json
        JSON.parse(super) unless super.nil?
    end

end