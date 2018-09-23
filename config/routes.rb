Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "shorten_urls#index"
  post "/add", to: "shorten_urls#add"
end
