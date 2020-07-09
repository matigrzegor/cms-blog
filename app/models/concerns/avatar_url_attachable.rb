module AvatarUrlAttachable

    def attach_avatar_url
        self.avatar_url = generate_avatar_url if self.avatar.attached?
    end

    private 

        def generate_avatar_url
            rails_blob_path(self.avatar, disposition: "attachment", only_path: true)
        end
end