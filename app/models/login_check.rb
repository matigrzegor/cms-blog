class LoginCheck
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email, :password

  validate :validate_user_exists
  validate :validate_password_correct

  def save
    if valid?
      true
    else
      false
    end
  end

  private

  def validate_user_exists
    if user.blank?
      errors.add(:base, 'No user found with this email.')
    end
  end

  def validate_password_correct
    if user && !correct_password?
      errors.add(:base, 'Wrong password for this email.')
    end
  end

  def user
    @user ||= User.find_for_database_authentication(email: email) if email.present?
  end

  def correct_password?
    user&.valid_for_authentication? { user.valid_password?(password) } && user&.active_for_authentication?
  end
end
