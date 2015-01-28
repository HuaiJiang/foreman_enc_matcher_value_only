module ForemanEncMatcherValueOnlyPatch
  def self.included(base)
      #base.extend ClassMethods
      base.class_eval do
          alias_method_chain :hashed_class_parameters, :matcher_value_only
        end
      end

       # create or overwrite class methods...
      def hashed_class_parameters_with_matcher_value_only

        unless Setting[:enc_matcher_value_only_environments].include?(@host.environment.to_s)
          Rails.logger.debug "ForemanEncMatcherValueOnlyPatch: return all"
          return hashed_class_parameters_without_matcher_value_only
        end

        Rails.logger.debug "ForemanEncMatcherValueOnlyPatch: return matcher value parameters only"
        h = {}
        begin
          path2matches.each do |match|
            LookupValue.where(:match => match).where(:lookup_key_id => class_parameters.map(&:id)).each do |value|
              key_id = value.lookup_key_id
              key = class_parameters.detect{|k| k.id == value.lookup_key_id }
              Rails.logger.debug "ForemanEncMatcherValueOnlyPatch: detect matcher parameters (#{key.to_s})"
              klass_id = key.environment_classes.first.puppetclass_id
              h[klass_id] ||= []
              h[klass_id] << key
            end
          end
        h
        rescue => e
          Rails.logger.error "ForemanEncMatcherValueOnlyPatch: skipping engine hook (#{e.to_s})"
        end

      end

  end
