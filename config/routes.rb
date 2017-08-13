Rails.application.routes.draw do
  root 'products#index'
  resources :products
  mount ImageUploader::UploadEndpoint => "/images"
end
