Rails.application.routes.draw do

  root to: 'boards#index'
  resources :tasks
  resources :boards
  devise_for :users
  get "task/board/:id", to: "tasks#new", as: :task_board

end

