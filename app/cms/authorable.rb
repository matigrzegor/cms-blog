module Authorable

    def add_author_username
        self.author_username = self.user.username
    end

end