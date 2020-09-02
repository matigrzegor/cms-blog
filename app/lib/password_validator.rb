class PasswordValidator < BaseServiceObject
  def self.call(user, password)
    new(user, password).call
  end

  def initialize(user, password)
    @user = user
    @password = password
  end

  def call
    if password_valid?
      success
    else
      failure
    end

    self
  end

  private

  def password_valid?
    @user&.valid_password?(@password)
  end
end
