class User < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  include AvatarUrlAttachable
  
  has_one_base64_attached :avatar

  before_save :attach_avatar_url

  has_many :blog_posts, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
      
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { maximum: 255 }
  validates :about, length: { maximum: 1000 }
end
