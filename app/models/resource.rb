class Resource < ActiveRecord::Base
  belongs_to :organisation
  has_many :resource_categories, dependent: :destroy
  has_many :categories, through: :resource_categories
  has_many :resource_target_groups, dependent: :destroy
  has_many :target_groups, through: :resource_target_groups
  has_many :resource_services, dependent: :destroy
  has_many :services, through: :resource_services

  include PgSearch
  pg_search_scope :search, against: { name: "A", description: "B", summary: "C" }, using: { tsearch: { dictionary: "english" } }

  scope :name_search, ->(search){ where('name LIKE ?', "%#{search}%") if search }
  scope :keyword_search, ->(keywords){ search(keywords).select("pg_search_resources.rank, resources.*") if keywords.present? }
  scope :categories, ->(category_ids) { joins(:categories).where(categories: { id: category_ids }).merge(Category.displayed) if category_ids.present? }
  scope :target_groups, ->(target_group_ids) { joins(:target_groups).where(target_groups: { id: target_group_ids }).merge(TargetGroup.displayed) if target_group_ids.present? }
  scope :services, ->(service_ids) { joins(:services).where(services: { id: service_ids }).merge(Service.displayed) if service_ids.present? }
  scope :displayed, ->{ where(display: true) }
  scope :location_search, ->(postcode, radius) { near(postcode, radius) if postcode.present? }

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  delegate :name, to: :organisation, prefix: true
  geocoded_by :postcode
  after_validation :geocode, if: ->(obj){ obj.postcode.present? && obj.postcode_changed? }

  validates :name, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

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

end
