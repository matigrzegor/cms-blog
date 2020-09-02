module AvatarUrlGeneratable
  def generate_avatar_url
    return domain_name + rails_blob_path(self.avatar, disposition: "attachment", only_path: true) if self.avatar.attached?

    nil
  end

  private

  def domain_name
    ENV['DOMAIN_NAME'] || 'localhost:3000'
  end
end
