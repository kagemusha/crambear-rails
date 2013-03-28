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
  
  def update
    set = params["card_set"]
    id = params.delete("id")
    p "pms: #{params}"
    params.delete "cards_count"
    card_set = CardSet.find(id)
    card_set.name = set["name"]
    if card_set.save!
      render json: card_set, status: :ok
    else
      render json: card_set.errors, status: :unprocessable_entity
    end
  end



  def destroy
    card_set = CardSet.find(params[:id])
    card_set.destroy
    render json: nil, status: :ok
  end
end
