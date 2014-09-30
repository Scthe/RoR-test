Rails.application.routes.draw do

  root 'application#login', as: :login
  get 'settings' => 'application#settings'
  get 'dashboard' => 'application#index', as: :dashboard

  resources :projects
  resources :tasks

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  resources :users, except: [ :create, :new]

  post 'tasks/:id/add_comment' => 'tasks#add_comment', as: :add_comment

end
