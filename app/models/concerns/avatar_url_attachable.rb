module AvatarUrlAttachable

    def attach_avatar_url
        self.avatar_url = service_url if self.avatar.attached?
    end
    
end