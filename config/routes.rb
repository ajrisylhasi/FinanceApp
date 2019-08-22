Rails.application.routes.draw do
  
  resources :doganas
  resources :destinims
  resources :kompanis, only: [:edit, :update, :show]
  resources :users
  get 'faturas/edit'
  get 'faturas/show'
  get 'reports/mbetja'
  get "/product_search", to: "reports#products"
  get "/import_search", to: "reports#imports"
  get "/official", to: "reports#official"
  get '/home', to: "static/home"
  
  get "/gjendja", to: "reports#gjendja"
  get "/mbetja", to: "reports#mbetja"
  get "/reportet", to: "static#reportet"
  get "/settings", to: "static#settings"
  get "/article_search", to: "static#article_present"
  
  resources :export_products, only: [:destroy]
  resources :import_articles, only: [:destroy]
  resources :normative_articles, only: [:destroy]
  resources :fees, only: [:destroy]
  resources :autorizim_articles, only: [:destroy]
  resources :autorizim_products, only: [:destroy]
  resources :product_packets, only: [:destroy]
  resources :explande_articles, only: [:destroy]
  resources :lists, only: [:destroy]
  resources :njesis
  resources :palet_products, only: [:destroy]
  resources :palet_packets, only: [:destroy]
  
  namespace :imports do
    get :charts
  end

  resources :palets do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  resources :exportlandes do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  resources :mbylljas
  resources :packing_lists
  resources :faturas
  resources :products
  resources :packets do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  resources :articles
  resources :imports do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  resources :garancions
  resources :normatives do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
      
    end
  end
  resources :clients
  resources :exports do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  resources :autorizims do 
    member do 
      delete "/delete_image_attachment", action: :delete_image_attachment
    end
  end
  
  get 'normatives/:id/files', to: 'normatives#files', as: 'normative_files'
  post 'normatives/change_category', to: 'normatives#make_test', as: "make_test"
  get 'users/:id/change_date', to: "users#change_date", as: "change_date"
  post 'users/:id/change_date', to: "users#change_date_post", as: "change_date_post"
  get 'exports/:id/files', to: 'exports#files', as: 'export_files'
  get 'exportlandes/:id/files', to: 'exportlandes#files', as: 'exportlandes_files'
  get 'autorizims/:id/files', to: 'autorizims#files', as: 'autorizim_files'
  get 'imports/:id/files', to: 'imports#files', as: 'import_files'
  get 'packets/:id/files', to: 'packets#files', as: 'packets_files'
  get 'palets/:id/files', to: 'palets#files', as: 'palets_files'
  get 'imports/:id/importi', to: 'imports#gjendja', as: "import_gjendja"
  get 'exports/:id/specifikacioni', to: 'exports#gjendja', as: "specifikacioni"
  get 'exports/:id/mbetja', to: 'exports#mbetja', as: "export_mbetja"
  get 'specifikacions', to: 'exports#specifikacions', as: "specifikacions"
  post 'faturas/:id', to: 'faturas#change_edit', as: "change_edit"
  get 'normatives/:id/normativa', to: "normatives#pdf", as: "normative_pdf"
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
end
