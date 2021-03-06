Rails.application.routes.draw do
  resources :search_terms do
    delete 'delete_term/:term', action: :delete_term, on: :collection, as: 'delete_term'
    post 'update_term/:term', action: :update_term, on: :collection, as: 'update_term'
    get 'filter', action: :filter_terms, on: :collection, as: 'filter_terms'
  end

  root 'search_terms#new'

end
