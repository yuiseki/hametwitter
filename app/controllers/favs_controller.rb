class FavsController < ApplicationController

  def index
    @statuses = Fav.find(:all, :limit=> 200)
    @users = Fav.count_by_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @favs }
    end
  end
end
