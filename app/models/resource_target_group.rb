class ResourceTargetGroup < ActiveRecord::Base
  belongs_to :resource
  belongs_to :target_group

  validates :resource, :target_group, presence: true
end
