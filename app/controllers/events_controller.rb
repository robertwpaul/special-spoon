class EventsController < ApplicationController
  before_action :find_event, only: [:show, :update, :destroy]
  def index
    json_response(Event.all)
  end

  def show
    json_response(@event)
  end

  def create
    event = Event.create!(event_params)
    json_response(event, :created)
  end

  def update
    @event.update(event_params)
    head :no_content
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def event_params
    params.permit(:title, :zip)
  end

  def find_event
    @event = Event.find_by!(id: params[:id])
  end
end
