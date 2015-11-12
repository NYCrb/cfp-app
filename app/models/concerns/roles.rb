# Defines role types, which are used throughout application models, various
#  procedures, and structures.
module Roles
  # @see comment in Proposal::State for issue on consts defined 2x.
  unless const_defined?(:ROLE_TYPES)
    ROLE_ORGANIZER = 'organizer'
    ROLE_REVIEWER  = 'reviewer'
    ROLE_TYPES     = [ROLE_ORGANIZER, ROLE_REVIEWER]
  end
end
