Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  resources :products do
    member do
      get 'who_bought'
    end
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      member do
        post 'decrease'
        post 'increase'
      end
    end
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
