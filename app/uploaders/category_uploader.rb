class CategoryUploader < Optimadmin::ImageUploader

  version :homepage do
    process resize_to_fill: [230, 230]
  end

end