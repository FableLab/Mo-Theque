class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!

  field :email, type: String
  field :user_name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :description, type: String
  field :admin, type: Boolean
  #field :stars, type: Integer, default: 0

  before_save { self.email = email.downcase }
  
  validates :password, length: { minimum: 6, maximum: 32 }, if: -> { new_record? || crypted_password_changed? }

  validates :password, confirmation: true, if: -> { new_record? || crypted_password_changed? }
  validates :password_confirmation, presence: true, if: -> { new_record? || crypted_password_changed? }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :user_name, uniqueness: true, length: { minimum: 2, maximum: 32 }

  validates :first_name, length: { maximum: 32 }
  validates :last_name, length: { maximum: 32 }

  validates :description, length: { maximum: 2000 }
end
