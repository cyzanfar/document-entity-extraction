Rails.application.routes.draw do

  root 'documents#index'

  resources :documents do
    resources :terminologies
  end

  resources :terminologies
end
