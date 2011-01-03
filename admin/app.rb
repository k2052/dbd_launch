class Admin < Padrino::Application             
  
  ##
  # Intializers
  #     
  
  # Core
  register Padrino::Helpers  
  register Sinatra::Flash
   
  # Authorizaition
  register Padrino::Admin::AccessControl 
  register MongoStoreInitializer
  
  ##
  # App Settings 
  #   
  
  # Sessions   
  set :session_id, 'dbd_club'  
  set :login_page, "/admin/sessions/new"         
  
  # Enables and Disables of padrino features
  disable :store_location   
  disable :flash    
 
  ## 
  # Access Rules
  #
  
  # Default
  access_control.roles_for :any do |role|
    role.protect "/"
    role.allow "/sessions"
  end
   
  access_control.roles_for :admin do |role|
    role.project_module :projects, "/projects"
    role.project_module :phases, "/phases"
    role.project_module :accounts, "/accounts"     
  end    
  
end