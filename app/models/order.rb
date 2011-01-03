class Order
  include MongoMapper::Document
  
  case Padrino.env
    when :development then self.set_database_name 'dbd_club_development'
    when :production  then self.set_database_name 'dbd_club_production'
  end
  
  # Keys
  key :order_num,   Integer 
  key :plan_id,     ObjectId
  key :status,      String 
  key :roles,       String  
  key :account_id,  ObjectId
  timestamps!
   
  # Associations
  belongs_to :account, :class_name => "Account", :foreign_key => "account_id"     
   
  def plan()   
    @plan = Plan.find(self[:plan_id])
  end   

end