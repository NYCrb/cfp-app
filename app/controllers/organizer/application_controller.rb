class Organizer::ApplicationController < ApplicationController
  before_action :require_event
  before_filter :require_organizer

  private

  def require_event
    @event = current_user &&
      if current_user.global_organizer?
        Event.find_by_id(params[:event_id] || params[:id])
      else
        current_user.organizer_events.find(params[:event_id] || params[:id])
      end
  end

  # Must be an organizer on @event
  def require_organizer
    unless @event
      session[:target] = request.path
      flash[:danger] = "You must be signed in as an organizer to access this page."
      redirect_to new_session_path
    end
  end

  def organizer_signed_in?
    user_signed_in? && @event && current_user.organizer_for_event?(@event)
  end
end
