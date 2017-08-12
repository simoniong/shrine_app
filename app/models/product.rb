class Product < ApplicationRecord
  include ImageUploader[:photo]

  validates :name, presence: true
  validates :photo, presence: true
end
