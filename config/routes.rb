Rails.application.routes.draw do
  post "/sign_up" => "api/v1/accounts/registrations#create", as: :create_user
  post "/create_connection" => "api/v1/users/connections#create", as: :create_connection

  ## 
  ## The following should have been a GET request, since the example shows the body, I have made it as POST.
  post "/list_friends_for_a_user" => "api/v1/users/connections#list_friends_for_a_user", as: :list_friends_for_a_user
  ##

  post "/mutual_friends" => "api/v1/users/connections#mutual_friends", as: :mutual_friends
  post "/block_updates_for_a_user" => "api/v1/users/connections#block_updates_for_a_user", as: :block_updates_for_a_user
  post "/unblock_friends" => "api/v1/users/connections#unblock_friends", as: :unblock_friends
end