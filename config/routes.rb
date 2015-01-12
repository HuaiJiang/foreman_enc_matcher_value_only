Rails.application.routes.draw do

  match 'new_action', :to => 'foreman_enc_matcher_value_only/hosts#new_action'

end
