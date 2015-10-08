class SubCategory < ActiveRecord::Base

  belongs_to :category, counter_cache: true

  has_many :resource_sub_categories, dependent: :destroy
  has_many :resources, through: :resource_sub_categories

  scope :displayed, ->{ where(display: true) }
  delegate :title, to: :category, prefix: true, allow_nil: true

  validates :name, presence: true, uniqueness: true

  def update_active_resources_count
    update_attribute(:active_resources_count, resources.merge(Resource.displayed).count)
  end
end
