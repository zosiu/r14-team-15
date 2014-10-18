Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations, :passwords]
  as :user do
    post :login, to: 'sessions#create', as: :user_session
    delete :logout, to: 'sessions#destroy', as: :destroy_user_session

    # post :password_reset, to: 'passwords#create', as: :user_password
    # get :edit_password, to: 'passwords#edit', as: :new_user_password
    # put :edit_password, to: 'passwords#edit', as: :edit_user_password

    post :register, to: 'registrations#create', as: :user_registration
  end

  get 'welcome/index'
  root 'welcome#index'

  get 'admin', to: 'admin#index', as: 'admin_root'

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?
end
