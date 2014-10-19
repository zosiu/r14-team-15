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
  get 'admin/projects', to: 'admin#projects', as: 'admin_projects'
  get 'admin/developers', to: 'admin#developers', as: 'admin_developers'

  get 'admin/builds', to: 'admin#builds', as: 'admin_builds'
  get 'admin/builds/red', to: 'admin#red_builds', as: 'admin_red_builds'
  get 'admin/builds/green', to: 'admin#green_builds', as: 'admin_green_builds'
  get 'admin/builds/:project', to: 'admin#project_builds', as: 'admin_project_builds'
  get 'admin/:developer/builds', to: 'admin#developer_builds', as: 'admin_developer_builds'

  get 'admin/codeship_settings', to: 'admin#codeship_settings', as: 'admin_codeship_settings'
  get 'admin/nabaztag_settings', to: 'admin#nabaztag_settings', as: 'admin_nabaztag_settings'

  post 'codeship/:codeship_uid/register_builds', to: 'codeship#register_builds', as: 'user_codeship_webhook'

  post 'guest_login', to: 'welcome#guest_login', as: :guest_login

  get 'bc.jsp', to: 'nabaztag#bytecode', as: :nabaztag_bytecode
  get 'nabaztag/:nabaztag_id', to: 'nabaztag#ping', as: :nabaztag_ping

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?
end
