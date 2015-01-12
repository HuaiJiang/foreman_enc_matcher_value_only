module ForemanEncMatcherValueOnly

  # Example: Plugin's HostsController inherits from Foreman's HostsController
  class HostsController < ::HostsController

    # change layout if needed
    # layout 'foreman_enc_matcher_value_only/layouts/new_layout'

    def new_action
      # automatically renders view/foreman_enc_matcher_value_only/hosts/new_action
    end

  end
end
