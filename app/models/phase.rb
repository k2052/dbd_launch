require 'kramdown' 
class Phase
  include MongoMapper::Document

  # Keys
  key :title,       String
  key :desc_source, String
  key :desc,        String  
  key :css_class,   String  
  key :start_date,  String
  key :end_date,    String
  timestamps!    
 
  # Associations 
  many :projects,  :foreign_key => "phase_id"  
  
  # Callbacks
  before_save :kramit     
  
  # Markdown 
  def kramit
    self.desc = Kramdown::Document.new(self.desc_source).to_html
  end
  
end