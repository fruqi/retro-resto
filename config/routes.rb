# frozen_string_literal: true

Rails.application.routes.draw do
  get 'reservations/index'
  get 'reservations/create'
  get 'reservations/update'
  get 'reservations/destroy'
  resources :guests

  resources :restaurants do
    resources :reservations
    resources :shift
  end
end
