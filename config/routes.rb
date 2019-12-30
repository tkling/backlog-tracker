# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index',                                    as: :home
  get 'instructions'        => 'user#instructions',     as: :instructions
  get ':user_id/games'      => 'user#games',            as: :user_games
  get ':user_id/roulette'   => 'user#backlog_roulette', as: :backlog_roulette
  get 'auth/start'          => 'auth#via_steam_openid', as: :auth_start
  get 'auth/result'         => 'auth#result',           as: :auth_result
  get 'about'               => 'home#about',            as: :about
  get 'logout'              => 'auth#logout',           as: :logout
end
