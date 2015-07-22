class ArticlePresenter < BasePresenter
  presents :article

  def title
    article.title
  end

  def content
    h.raw article.content
  end

  def image
    h.image_tag article.image.show, alt: article.title, class: 'page-image image-right' if article.image?
  end
end
