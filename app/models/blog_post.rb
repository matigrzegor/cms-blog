class BlogPost < ApplicationRecord
    include DataValidatable
    include ContentStorable
    include Authorable

    belongs_to :user

    attr_accessor :data

    before_save :add_author_username
    before_save :add_contents
    
    validates_presence_of :title, :introduction, :data
    validate :data_type

    private

        def add_contents
            raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

end
