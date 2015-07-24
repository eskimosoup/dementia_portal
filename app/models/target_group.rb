class TargetGroup < ActiveRecord::Base

  has_many :resource_target_groups, dependent: :destroy
  has_many :resources, through: :resource_target_groups

  validates :name, presence: true, uniqueness: true
end
