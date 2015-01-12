require 'foreman_enc_matcher_value_only_patch'

module ForemanEncMatcherValueOnly
  class Engine < ::Rails::Engine


    # Load this before the Foreman config initizializers, so that the Setting.descendants
    # list includes the plugin STI setting class
    initializer 'foreman_discovery.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/enc_matcher_value_only.rb", __FILE__) if (Setting.table_exists? rescue(false))
    end

    initializer 'foreman_enc_matcher_value_only.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_enc_matcher_value_only do
        requires_foreman '>= 1.5'

   end
    end

    #Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
         Classification::ClassParam.send(:include, ForemanEncMatcherValueOnlyPatch)
      rescue => e
        puts e.backtrace
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
