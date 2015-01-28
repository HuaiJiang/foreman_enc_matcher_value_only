class Setting::Enc_Matcher_Value_Only < Setting
  BLANK_ATTRS << 'enc_matcher_value_only_environments'

  def self.load_defaults
    # Check the table exists
    puts "loading matcher_value_only"

    return unless super

      Setting.transaction do
        [
          self.set('enc_matcher_value_only_environments', 'The environments that Foreman ENC return matcher value parameters only', []),
        ].compact.each { |s| self.create s.update(:category => 'Setting::General')}
      end

    true

  end

end
