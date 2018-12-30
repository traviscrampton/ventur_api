Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  resources :journals
  resources :chapters do 
    member do 
      put "update_blog_content"
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

  resources :users

  post "/chapters/upload_offline_chapter" => "chapters#upload_offline_chapter", :as => :upload_offline_chapter
end
