class Product < ApplicationRecord
  include ImageUploader[:photo]
end
