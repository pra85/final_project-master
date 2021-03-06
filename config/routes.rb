Broomble::Application.routes.draw do
  root :to => "home#index",
    :protocol => (Rails.env == "development" ? "http://" : "https://")

  get "/rss" => "home#index", :format => "rss"
  get "/news(.format)" => "home#index"

  get "/page/:page" => "home#index"

  get "/newest(.format)" => "home#newest"
  get "/newest/page/:page" => "home#newest"
  get "/newest/:user" => "home#newest_by_user"
  get "/newest/:user(.format)" => "home#newest_by_user"
  get "/newest/:user/page/:page" => "home#newest_by_user"

  get "/threads" => "comments#threads"
  get "/threads/:user" => "comments#threads"

  get "/login" => "login#index"
  post "/login" => "login#login"
  post "/logout" => "login#logout"

  post "/apilogin" => "login#apilogin"
  post "/apilogout" => "login#apilogout"

  get "/signup" => "signup#index"
  post "/signup" => "signup#signup"
  get "/signup/invite" => "signup#invite"

  match "/login/forgot_password" => "login#forgot_password",
    :as => "forgot_password"
  post "/login/reset_password" => "login#reset_password",
    :as => "reset_password"
  match "/login/set_new_password" => "login#set_new_password",
    :as => "set_new_password"

  match "/t/:tag" => "home#tagged", :as => "tag"
  match "/t/:tag/page/:page" => "home#tagged"

  get "/search" => "search#index"

  resources :stories do
    post "upvote"
    post "downvote"
    post "unvote"
    post "undelete"
  end
  post "/stories/fetch_url_title" => "stories#fetch_url_title"
  post "/stories/preview" => "stories#preview"

  resources :comments do
    post "upvote"
    post "downvote"
    post "unvote"

    post "edit"
    post "preview"
    post "update"
    post "delete"
    post "undelete"
  end
  get "/comments/page/:page" => "comments#index"
  get "/comments/page/:page(.format)" => "comments#index"
  post "/comments/post_to/:story_id" => "comments#create"
  post "/comments/preview_to/:story_id" => "comments#preview_new"

  get "/messages/sent" => "messages#sent"
  resources :messages do
    post "keep_as_new"
  end

  get "/s/:id/:title/comments/:comment_short_id" => "stories#show_comment"
  get "/s/:id/(:title)" => "stories#show"
  get "/s/:id/(:title)(.format)" => "stories#show"

  get "/u" => "users#tree"
  get "/u/:id" => "users#show"
  get "/u/:id(.format)" => "users#show"
  
  get "/settings" => "settings#index"
  post "/settings" => "settings#update"

  get "/filters" => "filters#index"
  post "/filters" => "filters#update"

  post "/invitations" => "invitations#create"
  get "/invitations" => "invitations#index"
  get "/invitations/request" => "invitations#build"
  post "/invitations/create_by_request" => "invitations#create_by_request",
    :as => "create_invitation_by_request"
  get "/invitations/confirm/:code" => "invitations#confirm_email"
  post "/invitations/send_for_request" => "invitations#send_for_request",
    :as => "send_invitation_for_request"
  get "/invitations/:invitation_code" => "signup#invited"

  get "/moderations" => "moderations#index"
  get "/moderations/page/:page" => "moderations#index"

  get "/privacy" => "home#privacy"
  get "/about" => "home#about"

 get "/apinews" => "home#apiindex"

 get "/apinewest" => "home#apinewest"
 
 get "/apinewest/:user" => "home#apinewest_by_user"
  
 get "/apis/:id/(:title)" => "stories#apishow"
  
 get "/apicomments/(page/:page)" => "comments#apicomments"
   
 get "/apiuser/:id" => "users#apishow"

 post "/apilogin" => "login#apilogin"
  
 post "/apilogout" => "login#apilogout"

end
