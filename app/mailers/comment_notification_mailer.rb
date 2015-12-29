class CommentNotificationMailer < ApplicationMailer
  def email_notification(comment)
    @comment = comment


    bcc = @comment.proposal.event.participants.map do |participant|
      if participant.notifications && (participant.role == 'reviewer' || participant.role == 'organizer')
        participant.person.email
      end
    end.compact

    # 'Global' reviewers and organizers aren't always a Participant of the 
    #  current event, so add them as well.
    Person.global_reviewers.each { |person|
      unless bcc.include? person.email
        bcc << person.email
      end
    }

    if bcc.any?
      mail_markdown(bcc: bcc,
           from: @comment.proposal.event.contact_email,
           subject: "A comment has been posted")
    end
  end
end
