module AvatarUrlAttachable

    def attach_avatar_url
        self.avatar_url = generate_url if self.avatar.attached?
    end
    
    private

        def generate_url
            domain_name = ENV['DOMAIN_NAME']
            
            url_path = rails_blob_path(self.avatar, disposition: "attachment", only_path: true)

            domain_name + url_path
        end
end