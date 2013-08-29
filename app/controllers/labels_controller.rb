class LabelsController < ApplicationController
	before_filter :authenticate_user!
  #skip_before_filter :verify_authenticity_token

  def label_params
    params.require(:label).permit :name
  end

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
    label = Label.new label_params
    card_set.labels << label
    card_set.save!
    respond_with label
  end
  
  def update
    label = Label.find(params["id"])
    if label.update label_params
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


end

