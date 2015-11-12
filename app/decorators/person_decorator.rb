class PersonDecorator < ApplicationDecorator
  delegate_all

  def proposal_path(proposal)
    event = proposal.event
    if object.organizer_for_event?(event)
      h.reviewer_event_proposal_path(event, proposal)
    elsif object.reviewer_for_event?(event)
      h.reviewer_event_proposal_path(event, proposal)
    else
      h.proposal_path(event.slug, proposal)
    end
  end

  # Allows selection of Events for review for interface display, based on 
  #  'global' status, or available Participation associations.
  def all_reviewer_events
    if global_reviewer?
      Event.live.recent
    else
      object.reviewer_events
    end
  end

  # Allows selection of Events for organization for interface display, based on
  #  'global' status, or available Participation associations.
  def all_organizer_events
    if global_organizer?
      Event.live.recent
    else
      object.organizer_events
    end
  end
end
