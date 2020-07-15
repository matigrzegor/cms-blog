module DataValidatable

    def validate_data_presence_and_type
        if data.present?
            if data.instance_of?(ActiveSupport::HashWithIndifferentAccess) || data.instance_of?(Hash)
                true
            else
                errors.add(:data, "has invalid format.")
                false
            end
        else
            errors.add(:data, "can't be blank when creating new record.")
            false
        end
    end
end