require "resque_web"

Rails.application.routes.draw do
  mount ResqueWeb::Engine => "/resque_web"

  resources :projects, only: [:index, :show]

  root "home#show"
end
