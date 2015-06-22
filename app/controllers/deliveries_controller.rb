class DeliveriesController < ApplicationController
  def login
    respond_to do |format|
      format.json do
        if key = params[:key]
          respond_with @driver = Driver.find_by(key: key)
        end
      end
    end
  end
  
  def index
    respond_to do |format|
      format.json do
        if params[:key]
          @delivery = Reciept.where(claimed: 0).each
        end
      end
    end
  end
end
