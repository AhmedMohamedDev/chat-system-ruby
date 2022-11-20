Rails.application.routes.draw do

  resources :messages
  resources :chats
  resources :applications
 # resources :messages
 # resources :chats
 # resources :applications
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :news
  end


  resources :applications do
    resources :chats do
      resources :messages do
      end
    end
  end
  
end

