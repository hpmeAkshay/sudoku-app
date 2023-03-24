Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/solve_sudoku', to: 'sudoku_solver#solve'
  # Defines the root path route ("/")
  # root "articles#index"
end
