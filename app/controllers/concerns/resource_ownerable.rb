module ResourceOwnerable

    def current_resource_owner
        @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def current_resource_owner_id
        @current_resource_owner_id ||= current_resource_owner.id if current_resource_owner
    end
end