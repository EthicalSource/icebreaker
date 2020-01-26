require "resque_web"

Rails.application.routes.draw do

  root "projects#index"

  mount ResqueWeb::Engine => "/resque_web"

end
