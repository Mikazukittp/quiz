Rails.application.routes.draw do
  devise_for :quiz_administrators
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :events, only: [:index, :show, :create, :destroy, :update] do
    member do
      get 'start'
      get 'set_url_token'
      get 'publish'
      get 'close'
      get 'next'
      delete 'clear'
    end

    collection do
       get 'show_with_token'
    end
  end

  resources :choices, only: [:index, :show, :destroy] do
    member do
      get 'is_correct'
    end
  end

  resources :questions, only: [:index, :show, :create, :destroy, :update] do
    get 'start'
    get 'end'
  end

  resources :answerers, only: [:index, :create, :show] do
    get 'answerers/get_question' => 'answerers#get_question'
    get 'answerers/get_event/:url_token' => 'answerers#get_event'
    get 'answerers/score' => 'answerers#show'
  end

  resources :answers, only: [:index, :show, :update, :create]
  resources :payments, only: [:create]
  resources :courses, only: [:index, :show]
  resource :authentication_token, only: [:update, :destroy]

  #devise用の記述
  devise_for :admin_users, controllers: { sessions: "session",
   registrations: "registration", confirmations: "confirmation",
   passwords: "password" }

  root to: "admin#index"

  devise_scope :admin_user do
    get '/admin_users/sign_out' => 'session#destroy'
  end



  #API用の記述
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :events, only: [:index, :show, :create, :destroy, :update] do
        get 'events/set_url_token/:id' => 'events#set_url_token'
        get 'events/publish/:id' => 'events#publish'
        get 'events/show_with_token/:url_token' => 'events#show_with_token'
        get 'events/start/:id' => 'events#start'
        get 'events/close/:id' => 'events#close'
        delete 'events/clear/:id' => 'events#clear'
        get 'events/next/:id' => 'events#next'
      end
    end
  end

  #存在しないURLの場合はすべて404を返す。
  if !Rails.env.development?
    get '*path', to: 'application#handle_404'
  end
end
