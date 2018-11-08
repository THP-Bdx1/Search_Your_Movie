Rails.application.routes.draw do
  root 'movies#home'
  post '/search', to: 'movies#search'
end
