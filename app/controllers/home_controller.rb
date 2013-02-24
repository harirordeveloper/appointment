class HomeController < ApplicationController
  def index
   @location = Location.new
  end
def aboutus
render :layout=>false 
end

def hospitals_clinics
render :layout=>false 
end
def labs
render :layout=>false 
end
def partners
render :layout=>false 
end
def search

end
def support
render :layout=>false 
end

end
