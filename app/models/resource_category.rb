class ResourceCategory < ActiveRecord::Base
  belongs_to :resource
  belongs_to :category

  validates :resource, :category, presence: true
end
