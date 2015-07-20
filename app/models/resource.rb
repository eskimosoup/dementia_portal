class Resource < ActiveRecord::Base
  belongs_to :organisation

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

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
