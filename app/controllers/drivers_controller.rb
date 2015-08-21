class DriversController < ApplicationController
  def create
    @driver = Driver.new(name: params[:name], key: params[:key], phone: params[:phone], license: params[:license], bank_info: params[:bank_info], amount_owed: 0.0)
    if @driver.save
      render :json => {message: "Success"}
    else
      render :json => {error: "Invalid parameters"}
    end
  end
  
  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver && @driver.key = params[:key]
      @driver.update_attributes(name: params[:name]) if params[:name]
      @driver.update_attributes(phone: params[:phone]) if params[:phone]
      @driver.update_attributes(license: params[:license]) if params[:license]
      @driver.update_attributes(bank_info: params[:bank_info]) if params[:bank_info]
      if @driver.save
        render :json => {message: "Update successful"}
      else
        render :json => {message: "Invalid input"}
      end
    else
      render :json => {error: "Invalid driver"}
    end
  end
  
  def update_owed
    @driver = Driver.find_by(id: params[:id])
    if @driver && @driver.key = params[:key]
      @driver.update_attributes(amount_owed: @driver.amount_owed + params[:owed])
      if @driver.save
        render :json => {message: "Account updated"}
      else
        render :json => {error: "Invalid amount"}
      end
    render :json => {error: "Invalid driver"}
    end
  end
  
  def delete
    @driver = Driver.find_by(id: params[:id])
    if @driver && @driver.key = params[:key]
      @driver.delete
      render :json => {message: "Driver deleted"}
    else
      render :json => {error: "Invalid driver"}
    end
  end
end
