module RegistrationTokenLifeCyclable
    
    def concoct
        registration_token = self.new
        registration_token.save!

        registration_token.token
    end

    def verify(token)
        time_now = Time.now.to_i
        
        registration_token = self.find_by_token(token)

        return false unless registration_token&.expires_in&. > time_now

        true
    end

    def remove(token)
        registration_token = self.find_by_token(token)

        registration_token.destroy
    end
end