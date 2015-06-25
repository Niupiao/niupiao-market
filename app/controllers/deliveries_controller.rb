class DeliveriesController < ApplicationController
  def login
    respond_to do |format|
      format.json do
        if @driver = Driver.find_by(key: params[:key])
          render :json => @driver
        else
          render :json => {error: "Invalid key"}
        end
      end
    end
  end
  
  def index
    respond_to do |format|
      format.json do
        if Driver.find_by(key: params[:key])
          @delivery = []
          Receipt.where(claimed: 0).find_each do |receipt|
            @delivery << receipt.to_delivery
          end
          render :json => @delivery
        else
          render :json => {error: "Invalid key"}
        end
      end
    end
  end
  
  def claim
    respond_to do |format|
      format.json do
        if @driver = Driver.find_by(key: params[:key])
          if @delivery = Receipt.find_by(id: params[:delivery_id])
            if @delivery.claimed == 0
              @delivery.update(claimed: @driver.id)
              render :json => @delivery.to_delivery
            else
              render :json => {error: "Receipt is already claimed"}
            end
          else
            render :json => {error: "Receipt does not exist"}
          end
        else
          render :json => {error: "Invalid key"}
        end
      end
    end
  end
end
