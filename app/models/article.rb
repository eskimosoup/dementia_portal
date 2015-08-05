class Article < ActiveRecord::Base

  mount_uploader :image, ArticleUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories

  scope :categories, ->(category_ids) { joins(:categories).where(categories: { id: category_ids }) if category_ids.present? }
  scope :displayed, ->{ where(display: true) }
  scope :active, -> { where("date <= ?", Date.today).displayed }

  validates :title, presence: true
  validates :date, :content, presence: true
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
