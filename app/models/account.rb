require 'digest/sha1'  

class Account
  include MongoMapper::Document
  attr_accessor :password 
  attr_accessor :name     
  
  case Padrino.env
    when :development then self.set_database_name 'dbd_club_development'
    when :production  then self.set_database_name 'dbd_club_production'
  end

  # Keys
  key :first_name,       String  
  key :last_name,        String
  key :username,         String
  key :email,            String
  key :crypted_password, String
  key :salt,             String
  key :roles,            Array     
  key :purchases,        Array   
  key :provider,         String 
  key :provider_uid,     String
      
  timestamps!

  # Validations
  if validations.empty?      
    validates_presence_of     :email 
    validates_presence_of     :password,                   :if => :password_required
    validates_presence_of     :password_confirmation,      :if => :password_required
    validates_length_of       :password, :within => 4..40, :if => :password_required
    validates_confirmation_of :password,                   :if => :password_required
    validates_length_of       :email,    :within => 3..100
    validates_uniqueness_of   :email,    :case_sensitive => false
    validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i             
  end       
                
  # Callbacks
  before_save :generate_password     
  
  # Associations

  ##
  # Methods
  #  
  
  # This method is for authentication purposes
  def self.authenticate(email, enc_password=nil, password=nil)  
    if password != nil   
      enc_password =  Digest::SHA1.hexdigest([email, password, ENV['PASS_SALT_SECRET']].join('::'))  
    end    
    account = self.first(:email => email) if email.present?
    account && account.crypted_password == Digest::SHA1.hexdigest([enc_password, account.salt].join('::')) ? account : nil  
  end
  
  # Called When Saving The Roles     
  def roles=(t)
    if t.kind_of?(String)
      t = t.downcase.split(",").join(" ").split(" ").uniq
    end
    self[:roles] = t
  end    

  # Called When Displaying Roles
  def roles_string()   
    self[:roles].join(",")  
  end
 
  # Checks to see if we have a role 
  def has_role?(role)     
    return self.roles.include?(role)
  end      
  
  def has_details?()
    if self[:last_name] != nil || self[:first_name] != nil || self[:username] != nil    
      return true
    else 
      return false
    end
  end 
   
  # Checks if a product has been pruchased 
  # We maintain an array purchased document IDs in the account model.
  # Which essentially allows a user to "purchase" any document.
  def has_purchased?(purchasedID) 
    if self.purchases.length > 0 
      purchasedID = BSON::ObjectId.from_string(purchasedID) 
      return self.purchases.include?(purchasedID)      
    else 
      return false
    end
  end     
   
  # Returns the name
  def name()  
    return "#{self[:first_name]}, #{self[:last_name]}"
  end

  private    
  
    def generate_password
      return if password.blank?
      self.salt             = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      password_pre_crypt    = Digest::SHA1.hexdigest([self.email, self.password, ENV['PASS_SALT_SECRET']].join('::'))
      self.crypted_password = Digest::SHA1.hexdigest([password_pre_crypt, self.salt].join('::'))
    end

    def password_required
      crypted_password.blank? || !password.blank?
    end
    
end