class ResourceService < ActiveRecord::Base
  belongs_to :resource
  belongs_to :service

  validates :resource, :service, presence: true
end
