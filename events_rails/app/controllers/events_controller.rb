class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @event }
    end
  end

  def create
    @event = Event.find_or_initialize_by(id: params[:event][:id])
    respond_to do |format|
      if @event.new_record?
        if @event.save
          format.html { redirect_to @event, notice: 'Event was succesfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    Event.destroy_all
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Events wass successfully destroyed' }
      format.json { head :no_content }
    end
  end
end
