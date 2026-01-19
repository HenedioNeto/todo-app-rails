Rails.application.routes.draw do
  devise_for :users

  root to: "task_lists#index"

  resources :task_lists do
    resources :tasks, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch :toggle
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end