class Order < ActiveRecord::Base
  belongs_to :user

#  PHONE_REGEX = /\A[0-9]{10,15}\Z/i.freeze
#  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i.freeze
  

#  validates :bill_firstname, presence: true,
#  validates :bill_lastname, presence: true,
#  validates :bill_address1, presence: true,
#  validates :bill_city, presence: true,
#  validates :bill_state, presence: true,
#  validates :bill_zipcode, presence: true,      
#                           length: 5
#  validates :ship_firstname, presence: true,
#  validates :ship_lastname, presence: true,
#  validates :ship_address1, presence: true,
#  validates :ship_city, presence: true,
#  validates :ship_state, presence: true,
#  validates :ship_zipcode, presence: true,
#                           length: 5
#  validates :phone, presence: true,
#                    format: PHONE_REGEX
#  validates :email, presence: true,
#                    format: EMAIL_REGEX

#    attr_accessor :card_number, :card_verification

#    validates_presence_of :email
#    validates_presence_of :bill_firstname
#    validates_presence_of :bill_lastname
#   validates_presence_of :bill_address1
#    validates_presence_of :bill_city
#    validates_presence_of :bill_state
#    validates_presence_of :bill_zipcode
#    validates_presence_of :ship_firstname
#    validates_presence_of :ship_lastname
#    validates_presence_of :ship_address1
#    validates_presence_of :ship_city
#    validates_presence_of :ship_state
#    validates_presence_of :ship_zipcode
#    validates_presence_of :phone
#    validates_format_of :email,
#      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
#      :on => :create
  end