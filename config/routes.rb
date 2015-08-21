Rails.application.routes.draw do
  get ':user_id/games'      => 'user#games',            as: :user_games
  get 'instructions'        => 'user#instructions',     as: :instructions
  get 'auth/start'          => 'auth#via_steam_openid', as: :auth_start
  get 'auth/result'         => 'auth#result',           as: :auth_result
  root 'home#index',                                    as: :home
end
