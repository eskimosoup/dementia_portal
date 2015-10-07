class ResourcePresenter < BasePresenter
  presents :resource

  delegate :to_model, to: :resource

  def id
    resource.id
  end

  def name
    resource.name
  end

  def distance
    return nil if !resource.respond_to?(:distance)
    h.content_tag :div, class: "distance right" do
      "#{ h.number_with_precision(resource.distance, precision: 2) } miles"
    end
  end

  def postcode
    resource.postcode
  end

  def hero_image
    if resource.categories.present? && resource.categories.first.image.present?
       h.image_tag resource.categories.first.image.show, alt: ''
    else
      h.image_tag 'layout/content/placeholder-bg.jpg', alt: ''
    end
  end

  def categories
    resource.categories.map{|x| x.title }.join(', ')
  end

  def linked_name
    h.link_to name, resource
  end

  def summary
    h.raw resource.summary
  end

  def description
    h.raw resource.description
  end

  def organisation_area
    return nil if organisation_name.nil?
    h.content_tag :div, class: "organisation-location" do
      h.concat(h.content_tag :span, organisation_name, class: "resource-organisation")
      h.concat(h.content_tag :span, "(#{postcode})", class: "resource-postcode") if postcode.present?
    end
  end

  def organisation_name
    @organisation_name ||= resource.organisation_name
  end

  def organisation_header
    return nil if organisation_name.nil?
    h.content_tag :h2, "#{ organisation_name } Resources"
  end

  def categories_list
    return nil if resource_sub_categories.nil?
    h.content_tag :ul, class: "resource-categories" do
      h.render partial: "categories/resource_category", collection: presented_resources, as: :category_presenter
    end
  end

  def resource_sub_categories
    @resource_sub_categories ||= resource.sub_categories
  end

  def website
    return nil if resource.url.blank?
    h.content_tag :div, class: "website" do
      h.concat(h.content_tag :h3, "Website", class: "associated-title")
      h.concat(h.link_to resource.url, resource.url, target: '_blank')
    end
  end

  def youtube
    return nil if resource.youtube_embed_code.blank?
    h.raw resource.youtube_embed_code
  end

  def date
    return nil if resource.date.blank?
    "Date: #{ resource.date }"
  end

  def time
    return nil if resource.time.blank?
    "Time: #{ resource.time }"
  end

  def venue
    return nil if resource.venue.blank?
    h.content_tag :div, resource.venue.html_safe, class: "venue"
  end

  def event?
    resource.date.present? || resource.time.present? || resource.venue.present?
  end

  def has_address?
    resource.postcode.present? && resource.address.present?
  end

  def address
    resource.address
  end

  def postcode
    resource.postcode
  end

  def contact_numbers?
    resource.main_phone.present? || resource.secondary_phone.present?
  end

  def main_phone
    resource.main_phone
  end

  def secondary_phone
    resource.secondary_phone
  end

  def data_hash
    {
      position: {
        lat: resource.latitude,
        lng: resource.longitude,
      },
      name: name,
      address: info_window_address,
      url: link
    }
  end

  private

  def presented_resources
    BaseCollectionPresenter.new(collection: resource_sub_categories,
                                view_template: view_template, presenter: SubCategoryPresenter)
  end

  def info_window_address
    [info_address, postcode].compact.join('<br/>')
  end

  def info_address
    address.split(", ") if address
  end

  def link
    h.resource_path(resource)
  end


end
