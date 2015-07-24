class Service < ActiveRecord::Base

  has_many :resource_services, dependent: :destroy
  has_many :resources, through: :resource_services

  validates :name, presence: true, uniqueness: true
end
