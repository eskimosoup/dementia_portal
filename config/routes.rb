Rails.application.routes.draw do
  get 'sitemap', to: 'application#sitemap'

  resources :frequently_asked_questions, only: :index, path: 'frequently-asked-questions'
  resources :pages, only: :show
  resources :articles, only: [:index, :show]
  resources :contacts, only: [:new, :create]
  resources :categories, only: :show
  resources :resources, only: [:index, :show] do
    collection do
      resources :target_groups, only: :show, path: 'group'
    end
  end

  mount Optimadmin::Engine => "/admin"
  root to: "application#index"
end
Optimadmin::Engine.routes.draw do
  resources :seo_entries, except: [:show] do
    collection do
      post 'order'
      get 'rebuild_seo'
    end
    member do
      get 'toggle'
    end
  end
  resources :pages, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :articles, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :frequently_asked_questions, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :resources, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :services, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :target_groups, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :organisations, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :categories, except: [:show] do
    collection do
      get 'reorder'
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
end
