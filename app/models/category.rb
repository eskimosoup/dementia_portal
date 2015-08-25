class Category < ActiveRecord::Base
  mount_uploader :image, CategoryUploader
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories
  has_many :frequently_asked_question_categories, dependent: :destroy
  has_many :frequently_asked_questions, through: :frequently_asked_question_categories
  has_many :sub_categories, dependent: :destroy
  has_many :resources, through: :sub_categories

  scope :home_page, -> { where(display: true, display_on_home: true) }
  scope :displayed, -> { where(display: true) }
  scope :has_subcategories, -> { where("sub_categories_count > ?", 0) }

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
