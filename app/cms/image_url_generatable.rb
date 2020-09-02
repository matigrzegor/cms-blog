module ImageUrlGeneratable
  def generate_url_from_blob(filename)
    blob = ActiveStorage::Blob.find_by_filename(filename)

    return domain_name + rails_blob_path(blob, disposition: 'attachment', only_path: true) if blob

    nil
  end

  private

  def domain_name
    ENV['DOMAIN_NAME'] || 'localhost:3000'
  end
end
