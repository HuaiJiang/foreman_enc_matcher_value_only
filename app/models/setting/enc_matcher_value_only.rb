class Setting::Enc_Matcher_Value_Only < Setting

  def self.load_defaults
    # Check the table exists
    puts "loading matcher_value_only"

    return unless super

      Setting.transaction do
        [
          self.set('enc_matcher_value_only', 'Foreman ENC return matcher value parameters only', false),
        ].compact.each { |s| self.create s.update(:category => 'Setting::General')}
      end

    true

  end

end
