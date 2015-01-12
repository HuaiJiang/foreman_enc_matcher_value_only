require 'deface'

module ForemanEncMatcherValueOnly
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer "foreman_enc_matcher_value_only.load_app_instance_data" do |app|
      app.config.paths['db/migrate'] += ForemanEncMatcherValueOnly::Engine.paths['db/migrate'].existent
    end

    initializer 'foreman_enc_matcher_value_only.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_enc_matcher_value_only do
        requires_foreman '>= 1.4'

        # Add permissions
        security_block :foreman_enc_matcher_value_only do
          permission :view_foreman_enc_matcher_value_only, {:'foreman_enc_matcher_value_only/hosts' => [:new_action] }
        end

        # Add a new role called 'Discovery' if it doesn't exist
        role "ForemanEncMatcherValueOnly", [:view_foreman_enc_matcher_value_only]

        #add menu entry
        menu :top_menu, :template,
             :url_hash => {:controller => :'foreman_enc_matcher_value_only/hosts', :action => :new_action },
             :caption  => 'ForemanEncMatcherValueOnly',
             :parent   => :hosts_menu,
             :after    => :hosts

        # add dashboard widget
        widget 'foreman_enc_matcher_value_only_widget', :name=>N_('Foreman plugin template widget'), :sizex => 4, :sizey =>1
      end
    end

    #Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanEncMatcherValueOnly::HostExtensions)
        HostsHelper.send(:include, ForemanEncMatcherValueOnly::HostsHelperExtensions)
      rescue => e
        puts "ForemanEncMatcherValueOnly: skipping engine hook (#{e.to_s})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanEncMatcherValueOnly::Engine.load_seed
      end
    end

  end
end
