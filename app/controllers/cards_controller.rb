class CardsController < ApplicationController
	before_filter :authenticate_user!
  respond_to :html, :json
  skip_before_filter :verify_authenticity_token #, :only=>[:destroy, :toggle_label]

  def index
    @card_set = current_user.card_sets.find(params[:card_set_id])
    render :json=>@card_set.cards
  end
  
  def show
    @card = cards.find(params[:id])
    render :json=>@card
  end
  
  ARCHIVED = "archived"

  def toggle_label
    @card = current_user.cards.find(params[:id])
    return if !@card #need error handle
    checked = (params[:checked] == "true" or params[:checked] == "checked")
    p "checkedzz", "check: #{params[:checked]}", checked
    if params[:label_id] == "archived"
      @card.update_attribute "archived", checked
    else
      @card.toggle_label params[:label_id], checked
    end
    Util.p "cardrabels", @card.labels_array
    respond_with(@card)
  end


  def new
    @card_set = current_user.card_sets.find(params[:card_set_id])
    @card = Card.new
    render "multi" if (params[:multi])
  end
  
  def create
    @card_set = current_user.card_sets.find(params[:card_set_id])
    @card = Card.new params[:card]
    updateArchAndLabels @card, params[:card]
    @card_set.cards << @card
    respond_with(@card)
  end
  
  def edit
    @card = current_user.cards.find(params[:id])
    return if !@card #need error handle
    @card_set = @card.card_set
    @edit = true
  end

  def update
    @card = current_user.cards.find(params[:id])
    if !@card
      @error_msg = "Can't find card"
    elsif @card.card_set.user != current_user
      @error_sg = "Not ur card buddy"
    end
    updateArchAndLabels @card, params[:card]
    @card.update_attributes(params[:card])
    #respond_with(@card)  #DOES NOT SEEM TO WORK FROM update method
    render :json=>@card.to_json

#    return if @error_msg
#    if @card.update_attributes(params[:card])
#      respond_to do |format|
#        #Util.p "fmt", format
#        format.html
#          flash[:notice] = "Successfully updated card."
#          redirect_to @card.card_set
#          return
#        format.js
#          Util.p "js"
#          render :json=> JSONResponse.new.to_json
#          return
#      end
#    end
  end
  
  def destroy
    p "delette me #{params[:id]}"
    @card = current_user.cards.find(params[:id])
    if !@card
      render :json=>JSONResponse.error("Card not found").to_json
      return
    end
    @card.destroy
    render :json=>JSONResponse.new.to_json
    #return
  end

  private

  #not sure why this isn't being done auto
  def updateArchAndLabels(card, card_params, save=false)
    card.labels_array = card_params["labels_array"]
    card.archived = (card_params["archived"] == "true")
  end

end
