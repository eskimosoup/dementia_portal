class Contact
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :name, :email, :query
  
  validates :name, :query, :email, presence: true
end
