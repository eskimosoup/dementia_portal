class ArticleUploader < Optimadmin::ImageUploader

  version :index do
    process resize_to_fill: [120, 120]
  end

  version :show do
    process resize_to_fill: [300, 300]
  end

end
