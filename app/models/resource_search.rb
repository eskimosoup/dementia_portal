class ResourceSearch

  include ActiveModel::Model
  attr_accessor :keywords, :category_ids, :target_group_ids, :service_ids

  def initialize(params = {})
    @keywords = fetch_keywords(params)
    @category_ids = fetch_checkbox_ids(params: params, key: :category_ids)
    @target_group_ids = fetch_checkbox_ids(params: params, key: :target_group_ids)
    @service_ids = fetch_checkbox_ids(params: params, key: :service_ids)
  end

  def resources
    # https://github.com/Casecommons/pg_search/issues/238 the select allows uniq to work
    Resource.displayed.categories(category_ids).services(service_ids).target_groups(target_group_ids).keyword_search(keywords).uniq
  end

  private

  def fetch_keywords(params)
    value = params.fetch(:keywords, nil)
    return nil if value.blank?
    value
  end

  def fetch_checkbox_ids(params:, key:)
    value = params.fetch(key, nil)
    return nil if value.nil? || value.reject(&:blank?).empty?
    value.reject(&:blank?).map(&:to_i)
  end


end