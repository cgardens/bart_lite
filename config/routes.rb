Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :arrivals
  get 'arrivals/go_to_work', controller: :arrivals, action: :go_to_work
  get 'arrivals/go_home', controller: :arrivals, action: :go_home
end
