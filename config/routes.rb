Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top'
    resources :orders, only: [:show]
    resources :customers, only: [:index, :show]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :public do
    get 'homes/about'

    resource :customers, only: [:show, :edit, :update] do
      collection do
        get :unsubscribe
        patch :withdraw
      end
    end
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
        collection do
        delete :destroy_all
      end
    end
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post :confirm
        get :complete
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
