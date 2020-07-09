module DataValidatable

    def data_type
        if data.present?
            if data.instance_of?(ActiveSupport::HashWithIndifferentAccess) || data.instance_of?(Hash)
                true
            else
                errors.add(:data, "has invalid format.")
            end
        else
            true
        end
    end
end