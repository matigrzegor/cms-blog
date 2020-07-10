module AvatarUrlAttachable

    def attach_avatar_url
        self.avatar_url = generate_url if self.avatar.attached?
    end
    
    private

        def generate_url
            self.avatar.service_url
        end
end