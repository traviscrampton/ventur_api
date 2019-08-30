Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  resources :journals do 
    member do 
      get :journal_metadata
    end

    resources :chapters, only: [:index]
    resources :gear_item_reviews, only: [:index]
  end

  resources :gear_item_reviews, only: [:show, :create, :update]

  resources :gear_items do 
    collection do 
      get :item_search
    end
  end

  resources :comments

  resources :credentials, only: [:index]

  resources :chapters do
    member do
      put "update_blog_content"
    end
  end

  resources :cycle_routes do 
    member do 
      get :editor_show
    end
  end

  resources :editor_blobs do
    member do
      put :update_final_to_draft
      put :update_draft_to_final
      put :update_blob_done
    end
  end

  resources :journal_follows do
    member do
      post "send_chapter_emails"
    end
  end

  resources :gear_items do
    member do
      put "update_gear_content"
    end
  end

  resources :strava_auths, only: [:show, :create, :destroy]

  resources :users do
    collection do
      post "login"
    end
  end

  resources :countries do 
    collection do 
      get "search_countries"
    end
  end

  post "/chapters/upload_offline_chapter" => "chapters#upload_offline_chapter", :as => :upload_offline_chapter
end
