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
  scope :keyword_search, ->(keywords){ search(keywords) if keywords }
  scope :categories, ->(category_ids) { joins(:resource_categories).where(resource_categories: { category_id: category_ids }) if category_ids }
  scope :target_groups, ->(target_group_ids) { joins(:resource_target_groups).where(resource_target_groups: { target_group_id: target_group_ids }) if target_group_ids }
  scope :services, ->(service_ids) { joins(:resource_services).where(resource_services: { service_id: service_ids }) if service_ids }
  scope :displayed, ->{ where(display: true) }

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  delegate :name, to: :organisation, prefix: true

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

  def self.resource_search(params)
    keyword_search(params[:keywords]).categories(params[:category_ids]).target_groups(params[:target_group_ids]).services(params[:service_ids])
  end
end
