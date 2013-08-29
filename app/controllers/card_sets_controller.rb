class CardSetsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def card_set_params
    params.require(:card_set).permit(:name, :description)
  end

  def index
    render :json => current_user.card_sets
  end
  
  def show
    card_set = CardSet.find_by_id(params[:id])
    if card_set
      render :json=>card_set
    else
      render :json => {:error => "not-found"}.to_json, :status => 404
    end
  end

  def create
    card_set = CardSet.new(card_set_params)
    current_user.card_sets << card_set
    current_user.save!
    respond_with card_set
  end
  
  def update
    card_set = CardSet.find(id)
    if card_set.update card_set_params
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
