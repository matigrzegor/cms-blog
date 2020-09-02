module ContentValidatable
  def content_in_json_not_nil
    if content_in_json.nil?
      errors.add(:content_in_json, "can't be nil.")
    else
      true
    end
  end

  def content_in_text_not_nil
    if content_in_text.nil?
      errors.add(:content_in_text, "can't be nil.")
    else
      true
    end
  end

  def content_in_html_not_nil
    if content_in_html.nil?
      errors.add(:content_in_html, "can't be nil.")
    else
      true
    end
  end
end
