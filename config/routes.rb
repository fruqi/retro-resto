# frozen_string_literal: true

Rails.application.routes.draw do
  resources :guests

  resources :restaurants do
    resources :reservations
    resources :shifts
    resources :tables
  end
end
