class CardsController < ApplicationController
	before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token #, :only=>[:destroy, :toggle_label]

  def index
    @card_set = current_user.card_sets.find(params[:card_set_id])
    render :json=>@card_set.cards
  end
  
  def show
    @card = cards.find(params[:id])
    render :json=>@card
  end
  
  def create
    card_set_id = params[:card].delete(:card_set_id)
    card_set = current_user.card_sets.find(card_set_id)
    card = Card.new params[:card]
    #updateArchAndLabels @card, params[:card]
    card_set.cards << card
    card_set.save!
    respond_with card
  end
  
  def update
  end
  
  def destroy
    card = Card.find(params[:id])
    card.destroy
    render json: nil, status: :ok
  end

  private


end

#def update
#  @card = current_user.cards.find(params[:id])
#  if !@card
#    @error_msg = "Can't find card"
#  elsif @card.card_set.user != current_user
#    @error_sg = "Not ur card buddy"
#  end
#  updateArchAndLabels @card, params[:card]
#  @card.update_attributes(params[:card])
#  #respond_with(@card)  #DOES NOT SEEM TO WORK FROM update method
#  render :json=>@card.to_json
#end


#ARCHIVED = "archived"
#
#def toggle_label
#  @card = current_user.cards.find(params[:id])
#  return if !@card #need error handle
#  checked = (params[:checked] == "true" or params[:checked] == "checked")
#  p "checkedzz", "check: #{params[:checked]}", checked
#  if params[:label_id] == "archived"
#    @card.update_attribute "archived", checked
#  else
#    @card.toggle_label params[:label_id], checked
#  end
#  Util.p "cardrabels", @card.labels_array
#  respond_with(@card)
#end

#private
##not sure why this isn't being done auto
#def updateArchAndLabels(card, card_params, save=false)
#  card.labels_array = card_params["labels_array"]
#  card.archived = (card_params["archived"] == "true")
#end
