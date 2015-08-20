class CategoryUploader < Optimadmin::ImageUploader

  version :homepage do
    process resize_to_fill: [224, 144]
  end

  version :show do
    process resize_to_fill: [960, 128]
  end

end
