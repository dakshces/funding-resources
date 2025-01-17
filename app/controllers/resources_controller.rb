class ResourcesController < ApplicationController
  before_action :find_resource, only: [:show]

  def new
    @resource = Resource.new
  end

 
  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:success] = "Resource successfully submitted for review!"
      redirect_to browse_path
    else
      render 'new'
    end
  end


  private
    def resource_params
      params.require(:resource).permit(:title, :source, :contact_person, :email)
    end


    def find_resource
      @resource = Resource.find(params[:id])
    end
end

