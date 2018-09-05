class TemperaturesController < ApplicationController

  def index
    @temperatures = Temperature.order('id DESC')
    if(params[:start_datetime].present?)
      start_datetime = Time.zone.local_to_utc(params[:start_datetime].to_datetime).in_time_zone
      @temperatures = @temperatures.where('created_at > ?', start_datetime)
    end
    @temperature = @temperatures&.first
    respond_to do |format|
      format.html
      format.json {render json: @temperatures}
    end
  end

  def create
    @temperature = Temperature.new(temperature_params)

    respond_to do |format|
      if @temperature.save
        format.html { redirect_to @temperature, notice: 'Temperature was successfully created.' }
        format.json { render :show, status: :created, location: @temperature }
      else
        format.html { render :new }
        format.json { render json: @temperature.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def temperature_params
    params.require(:temperature).permit(:temp)
  end
end
