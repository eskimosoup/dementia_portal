class TargetGroupPresenter < BasePresenter
  presents :target_group

  delegate :resources, to: :target_group, allow_nil: true

  def name
    target_group.name
  end

  def background_image
    h.image_tag 'layout/content/placeholder-bg.jpg', alt: ''
  end

  def colour
    target_group.colour
  end

  def resources_link
    h.link_to 'Resources <span>></span>'.html_safe, target_group, class: 'grey-button'
  end

  def overview_link
    h.link_to 'Overview <span>></span>'.html_safe, '#', class: 'white-button'
  end
end