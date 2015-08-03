class ArticlePresenter < BasePresenter
  presents :article

  delegate :to_model, to: :article

  def title
    article.title
  end

  def linked_title
    h.link_to title, article
  end

  def summary
    h.raw article.summary
  end

  def content
    h.raw article.content
  end

  def index_image
    h.image_tag article.image.index, alt: article.title, class: 'page-image image-right' if article.image?
  end

  def show_image
    h.image_tag article.image.show, alt: article.title, class: 'page-image image-right' if article.image?
  end
end
