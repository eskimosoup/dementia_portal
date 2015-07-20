class Organisation < ActiveRecord::Base
  ORGANISATION_TYPES = ["Charity", "Hull City Council", "Private Company" ]

  has_many :resources, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :postcode, :organisation_type, presence: true
  validates :organisation_type, presence: true, inclusion: { in: ORGANISATION_TYPES }

end
