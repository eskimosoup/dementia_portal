class TargetGroup < ActiveRecord::Base

  has_many :resource_target_groups, dependent: :destroy
  has_many :resources, through: :resource_target_groups
  belongs_to :page

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  scope :displayed, ->{ where(display: true) }

  validates :name, presence: true, uniqueness: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

  COLOURS = ['red', 'yellow', 'blue', 'orange']

  def slug_candidates
    [
      :suggested_url,
      :name,
      [:suggested_url, :name]
    ]
  end

  def should_generate_new_friendly_id?
    suggested_url_changed? || name_changed?
  end

  def update_active_resources_count
    update_attribute(:active_resources_count, resources.merge(Resource.displayed).count)
  end

end
