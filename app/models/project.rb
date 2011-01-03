class Project
  include MongoMapper::Document

  # Keys       
  key :title,        String
  key :short_desc,   String
  key :full_desc,    String
  key :progress,     Integer
  key :link_to_site, String
  key :phase_id,     ObjectId 
  timestamps!  
  
  # Key Settings 
  mount_uploader :image, ImageUploader 
   
end