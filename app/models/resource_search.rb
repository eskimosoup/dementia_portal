class ResourceSearch

  include ActiveModel::Model
  attr_accessor :keywords
  attr_writer :category_ids, :target_group_ids, :service_ids

  def category_ids
    return nil if @category_ids.reject(&:blank?).empty?
    @category_ids.map(&:to_i)
  end

  def target_group_ids
    return nil if @target_group_ids.reject(&:blank?).empty?
    @target_group_ids.map(&:to_i)
  end

  def service_ids
    return nil if @service_ids.reject(&:blank?).empty?
    @service_ids.map(&:to_i)
  end

  def keywords
    return nil if @keywords.blank?
  end

  def resources
    # .to_a.uniq because doing .uniq causes sql error
    Resource.displayed.categories(category_ids).services(service_ids).target_groups(target_group_ids).keyword_search(keywords).to_a.uniq
  end


end