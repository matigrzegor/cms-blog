class RegistrationToken < ApplicationRecord
  before_save :add_expires_in
  before_save :add_token
  extend RegistrationTokenLifeCyclable

  private

  def add_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def add_expires_in
    self.expires_in = Time.now.to_i + 86400
  end
end
