DbdLaunch.controllers :main do      
  
  get :index, :map => "/" do   
    @phases = Phase.all({:order => 'created_at asc'})        
    render "other/home"
  end     
end