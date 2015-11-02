require 'rails_helper'

describe PersonDecorator do
  describe "#proposal_path" do
    it "returns the path for a speaker" do
      speaker = create(:speaker)
      proposal = create(:proposal, speakers: [ speaker ])
      expect(speaker.person.decorate.proposal_path(proposal)).to(
        eq(h.proposal_path(proposal.event.slug, proposal)))
    end

    it "returns the path for a reviewer" do
      reviewer = create(:person, :reviewer)
      proposal = create(:proposal)
      expect(reviewer.decorate.proposal_path(proposal)).to(
        eq(h.reviewer_event_proposal_path(proposal.event, proposal)))
    end
  end

  describe 'reviewer and organizer event lists' do
    let(:global_reviewer) { create(:person, :global_reviewer) }
    let(:global_organizer) { create(:person, :global_organizer) }
    let(:person_without_participants) { create(:person) }
    let!(:person) { create(:person) }    
    let!(:event) { create(:event, state: 'open') }
    let!(:event_without_participants) { create(:event, state: 'open') }
    let!(:participant) { create(:participant, event: event, person: person, role: Roles::ROLE_ORGANIZER) }


    describe '#all_reviewer_events' do
      it 'returns the event for the global reviewer' do
        expect(global_reviewer.decorate.all_reviewer_events).to contain_exactly(event, event_without_participants)
      end

      it 'returns only event for non global person' do
        expect(person.decorate.all_reviewer_events).to(eq([event]))
      end

      it 'does not return events for the person with no participants' do
        expect(person_without_participants.decorate.all_reviewer_events).to be_empty
      end
    end

    describe '#all_organizer_events' do
      it 'returns all events for the global organizer' do
        expect(global_organizer.decorate.all_organizer_events).to contain_exactly(event, event_without_participants)
      end

      it 'returns only event for non global person' do
        expect(person.decorate.all_organizer_events).to(eq([event]))
      end

      it 'does not return events for the person with no participants' do
        expect(person_without_participants.decorate.all_organizer_events).to be_empty
      end
    end
  end
end
