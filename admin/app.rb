class Admin < Padrino::Application             
  
  ##
  # Intializers
  #     
  register Padrino::Helpers   
  register Padrino::Rendering   
  register CompassInitializer
  register Sinatra::Flash
  register Padrino::Admin::AccessControl 
  
  # Sessions   
  set :session_id, 'dbd_club'  
  set :login_page, "/admin/sessions/new"         
  
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