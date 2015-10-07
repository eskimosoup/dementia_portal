class ResourceSearch

  RADIUS_OPTIONS = [
    ["2 miles", 2],
    ["5 miles", 5],
    ["10 miles", 10],
    ["20 miles", 20]
  ]

  include ActiveModel::Model
  include Virtus.model
  attribute :keywords, String
  attribute :postcode, String
  attribute :radius, Integer
  attribute :target_group_ids, Array[Integer]
  attribute :sub_category_ids, Array[Integer]

  def resources
    @resources ||= Resource.displayed.sub_categories(sub_category_ids_no_blanks)
        .target_groups(target_group_ids_no_blanks).keyword_search(keywords)
        .location_search(postcode, radius).uniq.order(:name)
  end

  def resources_count
    resources.size
  end

  def sub_category_ids_no_blanks
    sub_category_ids.reject(&:blank?)
  end

  def category_ids
    SubCategory.where(id: sub_category_ids_no_blanks).pluck(:category_id).uniq
  end

  def target_group_ids_no_blanks
    target_group_ids.reject(&:blank?)
  end

  def postcode?
    postcode.present?
  end

end