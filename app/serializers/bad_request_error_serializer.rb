class BadRequestErrorSerializer
  def initialize(object: nil, details: nil)
    @active_record_object = object
    @details = details
  end

  def serializable_hash
    serializable_hash = {}
    serializable_hash.merge!(base_attributes_hash)
    serializable_hash.merge!(details_attribute_hash) if @active_record_object || @details
    serializable_hash
  end

  private

  def base_attributes_hash
    {
      status: 'Bad Request',
      code: 400
    }
  end

  def details_attribute_hash
    {
      details: @details || @active_record_object.errors.full_messages.join('. ')
    }
  end
end
