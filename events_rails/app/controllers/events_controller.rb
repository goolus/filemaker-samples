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
      if @event.update_or_create(event_params)
        format.html { redirect_to @event, notice: 'Event was succesfully updated.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
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

  private

  def event_params
    params.require(:event).permit(:id, :organizer, :image, :body, :title, :pub_date)
  end
end
