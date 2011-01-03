class Plan
  include MongoMapper::Document
  
  case Padrino.env
    when :development then self.set_database_name 'dbd_club_development'
    when :production  then self.set_database_name 'dbd_club_production'
  end

  # Keys
  key :plan,            String
  key :signup_price,    Integer  
  key :recurring_price, Integer
  
end