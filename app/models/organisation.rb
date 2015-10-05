class Organisation < ActiveRecord::Base
  ORGANISATION_TYPES = ["Charity", "Hull City Council", "Private Company", "Not for Profit", "NHS", "Government", "TBC"]
  scope :name_search, ->(search){ where('name LIKE ?', "%#{search}%") if search }

  has_many :resources, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :organisation_type, presence: true, inclusion: { in: ORGANISATION_TYPES }

end
