# Some extensions to padrino's access control to allow multiple roles.
# Roles are simply an array on the account model.
Padrino::Admin::AccessControl::Base.class_eval do 
  
  def project_modules(account)        
    acc_roles = account.roles 
    authorizations = nil
    acc_roles.each do |role|   
      role = role.to_sym
      authorizations = @authorizations.find_all { |auth| auth.roles.include?(role) }
    end    
    authorizations.collect(&:project_modules).flatten.uniq   
  end
   
  def allowed?(account=nil, path=nil)
    path = "/" if path.blank?
    authorizations = @authorizations.find_all { |auth| auth.roles.include?(:any) }
    allowed_paths  = authorizations.collect(&:allowed).flatten.uniq
    denied_paths   = authorizations.collect(&:denied).flatten.uniq        
    if account      
      denied_paths.clear
      acc_roles = account.roles
      acc_roles.each do |role|  
        role = role.to_sym
        authorizations = @authorizations.find_all { |auth| auth.roles.include?(role) }
        allowed_paths += authorizations.collect(&:allowed).flatten.uniq
        authorizations = @authorizations.find_all { |auth| !auth.roles.include?(role) && !auth.roles.include?(:any) }
        denied_paths  += authorizations.collect(&:allowed).flatten.uniq
        denied_paths  += authorizations.collect(&:denied).flatten.uniq   
      end
    end  
    return true  if allowed_paths.any? { |p| path =~ /^#{p}/ }
    return false if denied_paths.any?  { |p| path =~ /^#{p}/ }
    true
  end 
                                                                      
end