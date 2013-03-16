class CardSetsController < ApplicationController
	before_filter :authenticate_user!
  respond_to :json
  #skip_before_filter :verify_authenticity_token, :only=>[:destroy]

  def index
    render :json => current_user.card_sets
  end
  
  def show
    card_set = CardSet.find(params[:id])
    render :json=>card_set
  end

  def create
    card_set = CardSet.new(params[:card_set])
    current_user.card_sets << card_set
    current_user.save!
    respond_with card_set
  end
  
  #def update
  #  contact = Contact.find(params[:id])
  #  if update_contact(contact)
  #    render json: contact, status: :ok
  #  else
  #    render json: contact.errors, status: :unprocessable_entity
  #  end
  #end
  
  def destroy
    card_set = CardSet.find(params[:id])
    card_set.destroy
    render json: nil, status: :ok
  end
end
