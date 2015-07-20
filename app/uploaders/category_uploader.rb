class CategoryUploader < Optimadmin::ImageUploader

  version :homepage do
    process resize_to_fill: [300, 300]
  end

end