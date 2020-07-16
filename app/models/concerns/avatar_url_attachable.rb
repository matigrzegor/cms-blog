module AvatarUrlAttachable

    def generate_avatar_url
        domain_name = ENV['DOMAIN_NAME'] || "localhost:3000"
        
        return domain_name + rails_blob_path(self.avatar, disposition: "attachment", only_path: true) if self.avatar.attached?

        nil
    end
    
end