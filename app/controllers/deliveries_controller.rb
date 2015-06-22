class DeliveriesController < ApplicationController
  def login
    if key = params[:key]
      @driver = Driver.find_by(key: key)
    end
  end
end
