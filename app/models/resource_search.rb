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
  attribute :category_ids, Array[Integer]
  attribute :target_group_ids, Array[Integer]
  attribute :service_ids, Array[Integer]

  def resources
    # https://github.com/Casecommons/pg_search/issues/238 the select allows uniq to work
    Resource.displayed.categories(category_ids.reject(&:blank?)).services(service_ids.reject(&:blank?))
        .target_groups(target_group_ids.reject(&:blank?)).keyword_search(keywords).location_search(postcode, radius).uniq
  end

end