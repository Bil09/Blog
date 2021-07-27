class User < ApplicationRecord
has_many :articles
has_secure_password
before_save  { self.email = email.downcase }     
validates :username, presence: true,
    uniqueness: { case_sensitive: false },
    length: {minimum:3, maximum:25}
VALID_EMAIL_REGEX= /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[a-z]+\z/i    
validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: {minimum:5, maximum:110},
    format: { with: VALID_EMAIL_REGEX,multiline:true }

end