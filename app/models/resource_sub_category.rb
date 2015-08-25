class ResourceSubCategory < ActiveRecord::Base
  belongs_to :resource
  belongs_to :sub_category

  validates :resource, :sub_category, presence: true
end
