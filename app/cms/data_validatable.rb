module DataValidatable

    def data_type
        if data.instance_of?(ActiveSupport::HashWithIndifferentAccess)
            true
        else
            errors.add(:data, "has invalid format.")
        end
    end
end