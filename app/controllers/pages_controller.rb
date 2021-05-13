class PagesController < ApplicationController
  def home
  end

  def contact
  end

  def browse
    @resources = Resource.all
  end 
  
end
