Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  resources :journals

  resources :comments

  resources :chapters do
    member do
      put "update_blog_content"
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

  resources :users do
    collection do
      post "login"
    end
  end

  post "/chapters/upload_offline_chapter" => "chapters#upload_offline_chapter", :as => :upload_offline_chapter
end
