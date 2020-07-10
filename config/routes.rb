Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:id/shelter_reviews/', to: 'shelter_reviews#index'
  get '/shelters/:id/shelter_reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:id/shelter_reviews', to: 'shelter_reviews#create'
  get '/shelters/:id/shelter_reviews/:id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:id/shelter_reviews/:id', to: 'shelter_reviews#update'
  delete '/shelters/:id/shelter_reviews/:id', to: 'shelter_reviews#destroy'

  patch '/favorites/:pet_id', to: 'favorites#update'
  get 'favorites', to: 'favorites#index'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
end
