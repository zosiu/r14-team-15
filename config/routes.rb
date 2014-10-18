Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations]
  as :user do
    post :login, to: 'sessions#create', as: :user_session
    delete :logout, to: 'sessions#destroy', as: :destroy_user_session

    post :register, to: 'registrations#create', as: :user_registration
  end

  get 'welcome/index'
  root 'welcome#index'

  get 'admin', to: 'admin#index', as: 'admin_root'

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?
end
