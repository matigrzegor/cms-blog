module Authorable

    def add_author_username
        self.author_username = self.user.username
    end

    def add_author_avatar_url
        self.author_avatar_url = self.user.avatar_url
    end
end