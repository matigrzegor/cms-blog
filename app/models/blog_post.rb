class BlogPost < ApplicationRecord
    include DataValidatable
    include ContentStorable
    include Authorable

    belongs_to :user

    attr_accessor :data

    before_save :add_author_username
    before_save :add_author_avatar_url
    
    before_save :add_contents, unless: -> { data_blank_and_record_not_new }
    
    validates_presence_of :title, :introduction
    validate :data_type
    
    private

        def add_contents
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        def data_blank_and_record_not_new
            data.blank? && !self.new_record?
        end
end
