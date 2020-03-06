class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :only_users
  before_action :auth_check, only: [:edit, :update, :destroy] #aplication_helper.rb

  def index
    @events = Event.order(:event_start_at :desc)
  end

  def show
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "Event created."
      redirect_to @event 
    else
      flash[:error] = "Failed to create event."
      render :new 
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated."
      redirect_to @event
    else
      flash[:error] = "Failed to update."
      render :new
    end
  end

  def destroy
    if @event.destroy 
      flash[:success] = "Event deleted from existence."
      redirect_to root_path
    else
      flash[:error] = "Failed to delete event."
      redirect_back(fallback_location: root_path)
    end
  end

  def attend_event
  end

  def cancel_event
  end

  def send_invitation
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :event_type, :event_start_at, :event_end_at)
  end

  def only_users
    redirect_to(root_url) unless logged_in?
  end

end
