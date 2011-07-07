Admin.controllers :phases do

  get :index do
    @phases = Phase.all
    render 'phases/index'
  end

  get :new do
    @phase = Phase.new
    render 'phases/new'
  end

  post :create do
    @phase = Phase.new(params[:phase])
    if @phase.save
      flash[:notice] = 'Phase was successfully created.'
      redirect url(:phases, :edit, :id => @phase.id)
    else
      render 'phases/new'
    end
  end

  get :edit, :with => :id do
    @phase = Phase.find(params[:id])
    render 'phases/edit'
  end

  put :update, :with => :id do
    @phase = Phase.find(params[:id])
    if @phase.update_attributes(params[:phase])
      flash[:notice] = 'Phase was successfully updated.'
      redirect url(:phases, :edit, :id => @phase.id)
    else
      render 'phases/edit'
    end
  end

  delete :destroy, :with => :id do
    phase = Phase.find(params[:id])
    if phase.destroy
      flash[:notice] = 'Phase was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Phase!'
    end
    redirect url(:phases, :index)
  end 
end