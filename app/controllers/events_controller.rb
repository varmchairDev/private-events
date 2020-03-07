class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy, 
                                   :attend_event, :cancel_event, :send_invitation]
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
    redirect_back(fallback_location: root_path) unless !@event.attendees.include?(current_user)
    @event.attendees << current_user
    redirect_back(fallback_location: root_path)
  end

  def cancel_event
    redirect_back(fallback_location: root_path) unless @event.attendees.include?(current_user)
    @event.attendees.delete(current_user)
    redirect_back(fallback_location: root_path) 
  end

  def send_invitation
    redirect_back(fallback_location: root_path) unless current_user.name != params[:invite][:user_name]
    invited = User.find_by(name: params[:invite][:user_name])
    redirect_back(fallback_location: root_path) unless 
                         Invitation.find_by(inviter_id: current_user.id, invited_id: invited.id, event_id: @event.id).nil?
    new_invitation = Invitation.new(inviter_id: current_user.id, invited_id: invited.id, event_id: @event.id)
    if new_invitation.save
      flash[:success] = "Invitations sended."
    else 
      flash[:error] = "Failed to send invitation."
    end
    redirect_back(fallback_location: root_path)
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
