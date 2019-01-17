Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users/:id',             to: 'users#read',
                                as: 'users_read'

  post '/users',                to: 'users#write',
                                as: 'users_write'

  post '/users/:id',            to: 'users#update',
                                as: 'users_update'

  get '/workouts/:id',          to: 'workouts#read',
                                as: 'workouts_read'

  get '/workouts',              to: 'workouts#query',
                                as: 'workouts_query'

  post '/workouts',             to: 'workouts#write',
                                as: 'workouts_write'

  post '/workouts/:id',         to: 'workouts#update',
                                as: 'workouts_update'

  get '/exercises/:id',         to: 'exercises#read',
                                as: 'exercises_read'

  get '/exercises',             to: 'exercises#query',
                                as: 'exercises_query'

end
