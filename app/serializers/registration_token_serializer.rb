class RegistrationTokenSerializer
  def initialize(object: nil)
    @active_record_object = object
  end

  def serializable_hash
    return single_resource_serializable_hash if @active_record_object

    {}
  end

  private

  def single_resource_serializable_hash
    base_attributes_hash(@active_record_object)
  end

  def base_attributes_hash(active_record_object)
    {
      token: active_record_object.token
    }
  end
end
