class LabelsController < ApplicationController
	before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token #, :only=>[:destroy, :toggle_label]

  def index
    @card_set = current_user.card_sets.find(params[:card_set_id])
    render :json=>@card_set.labels
  end
  
  def show
    @label = labels.find(params[:id])
    render :json=>@label
  end
  
  def create
    card_set_id = params[:label].delete(:card_set_id)
    card_set = current_user.card_sets.find(card_set_id)
    label = Label.new params[:label]
    #updateArchAndLabels @label, params[:label]
    card_set.labels << label
    card_set.save!
    respond_with label
  end
  
  def update
    label = Label.find(params["id"])
    label_params = params["label"]
    label_params.delete "card_set_id"
    label.update_attributes label_params
    if label.save!
      render json: label, status: :ok
    else
      render json: label.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    label = Label.find(params[:id])
    label.destroy
    render json: nil, status: :ok
  end


  private


end



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
