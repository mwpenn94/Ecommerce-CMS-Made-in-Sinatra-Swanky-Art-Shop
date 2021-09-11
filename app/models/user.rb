class User < ActiveRecord::Base
  has_many :orders
  
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i.freeze

  validates :username, presence: true,
                   uniqueness: true,
                   length: { minimum: 2 }
  validates :email, presence: true,
                    format: EMAIL_REGEX
  validates :password, length: { in: 6..10 }

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(input_text)
    #User.all.find{|user| user.slug == slug}
    User.where(slug: input_text)
  end
end


