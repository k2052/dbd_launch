DbdLaunch.helpers do   
  
  def build_auth_array(auth)  
    new_auth = {}   
    new_auth['provider']     = auth['provider']
    new_auth['provider_uid'] = auth['uid']    
    new_auth['username']     = auth['user_info']['username']
    new_auth['first_name']   = auth['user_info']['first_name']
    new_auth['last_name']    = auth['user_info']['last_name']
    return new_auth   
  end   
  
end