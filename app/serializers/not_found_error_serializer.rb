class NotFoundErrorSerializer
  def serializable_hash
    serializable_hash = {}
    serializable_hash.merge!(base_attributes_hash)
    serializable_hash
  end

  private

  def base_attributes_hash
    {
      status: 'Not Found',
      code: 404
    }
  end
end
