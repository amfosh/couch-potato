class User < ActiveRecord::Base
    has_secure_password
    has_many :shows
    
    def slug
        self.username.downcase.split.join("-")
    end
    
    def self.find_by_slug(slug)
        self.all.find {|object| object.username if object.slug == slug}
    end
end