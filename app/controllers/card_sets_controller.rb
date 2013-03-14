class CardSetsController < ApplicationController
	before_filter :authenticate_user!
  respond_to :html, :json
  skip_before_filter :verify_authenticity_token, :only=>[:destroy]

  def index
    render :json => current_user.card_sets
  end
  
  def show
    @card_set = CardSet.find(params[:id])
    render :json=>@card_set
  end


  def new
    @card_set = CardSet.new
  end
  
  def create
    p("pamz", params[:card_set])
    @card_set = CardSet.new(params[:card_set])
    current_user.card_sets << @card_set
    respond_with(@card_set)
  end
  
  def edit
    @card_set = current_user.card_sets.find(params[:id])
  end
  
  def update
    @card_set = current_user.card_sets.find(params[:id])
    @card_set.update_attributes(params[:card_set])
    #respond_with(@card_set) #doesn't work for some reason
    render :json=>@card_set.to_json
  end
  
  def destroy
    @card_set = current_user.card_sets.find(params[:id])
    if !@card_set
      render :json=>JSONResponse.error("Card set not found").to_json
      return
    end
    @card_set.destroy
    render :json=>JSONResponse.new().to_json
  end
end
