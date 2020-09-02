class QuillBlogPostSerializer
  def initialize(object: nil, type: :single)
    @active_record_object = object
    @type = type
  end

  def serializable_hash
    if @type == :single
      return single_resource_serializable_hash if @active_record_object

      {}
    elsif @type == :multiple
      return multiple_resource_serializable_hash if @active_record_object

      []
    end
  end

  private

  def single_resource_serializable_hash
    base_attributes_hash(@active_record_object).merge!(data_attribute_hash(@active_record_object))
  end

  def multiple_resource_serializable_hash
    @active_record_object.map do |active_record_object|
      base_attributes_hash(active_record_object)
    end
  end

  def base_attributes_hash(active_record_object)
    {
      id: active_record_object.id,
      author: active_record_object.author_username,
      create_date: active_record_object.created_at,
      last_update_date: active_record_object.updated_at,
      title: active_record_object.title,
      introduction: active_record_object.introduction
    }
  end

  def data_attribute_hash(active_record_object)
    {
      data: {
        editor: active_record_object.editor,
        ops: Quill::ImageUrlsAdder.new(active_record_object).add
      }
    }
  end
end
