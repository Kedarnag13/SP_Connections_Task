class User < ActiveRecord::Base
  has_friendship
  acts_as_mentionable
  acts_as_mentioner

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9!@#$%^&*()]+\.)+[a-z0-9!@#$%^&*()]{2,})\z/i, message: :invalid_email_format

end
