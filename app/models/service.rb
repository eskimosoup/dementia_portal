class Service < ActiveRecord::Base

  has_many :resource_services, dependent: :destroy
  has_many :resources, through: :resource_services

  scope :displayed, ->{ where(display: true) }

  validates :name, presence: true, uniqueness: true
end