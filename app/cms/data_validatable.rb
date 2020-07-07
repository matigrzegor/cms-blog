module DataValidatable

    def data_type
        if data.instance_of?(ActiveSupport::HashWithIndifferentAccess) || data.instance_of?(Hash)
            true
        else
            errors.add(:data, "has invalid format.")
        end
    end
end