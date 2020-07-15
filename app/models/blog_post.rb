class BlogPost < ApplicationRecord
    include DataValidatable
    include ContentStorable
    include ContentValidatable
    include Authorable

    include ActiveStorageSupport::SupportForBase64
    include Rails.application.routes.url_helpers
    include ImageLinkGeneratable
    
    extend Paginatable

    has_many_base64_attached :images

    belongs_to :user

    attr_accessor :data

    before_save :add_author_username
    before_save :add_author_avatar_url
    
    #before_save :add_contents, unless: -> { data_blank_and_record_not_new }
    
    validates_presence_of :title, :introduction, :editor
    validate :content_in_json_not_nil
    validate :content_in_text_not_nil
    validate :content_in_html_not_nil
    #validate :data_presence_and_type, unless: -> { data_blank_and_record_not_new }
    
    private

        def add_contents
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        def data_blank_and_record_not_new
            data.blank? && !self.new_record?
        end
end
