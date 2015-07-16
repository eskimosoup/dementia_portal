class Category < ActiveRecord::Base
  mount_uploader :image, CategoryUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  scope :home_page, -> { where(display: true, display_on_home: true) }

  validates :title, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }

  def slug_candidates
    [
      :suggested_url,
      :title,
      [:suggested_url, :title]
    ]
  end

  def should_generate_new_friendly_id?
    suggested_url_changed? || title_changed?
  end
end
