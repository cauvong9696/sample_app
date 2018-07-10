Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"
  # scope "(:locale)", locale: /en|vi/ do
  #     get "static_pages/help"
  #   end
  # root "static_pages#home"
end
