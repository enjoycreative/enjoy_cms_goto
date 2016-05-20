module Enjoy
  module Goto
    def self.configuration
      @configuration ||= Configuration.new
    end
    def self.config
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    class Configuration

      attr_accessor :css_selector
      attr_accessor :href_regex
      attr_accessor :excluded_hosts

      attr_accessor :add_nofollow
      attr_accessor :add_noindex
      attr_accessor :add_noreferrer
      attr_accessor :add_noopener
      attr_accessor :del_attrs

      def initialize
        @css_selector = "a[href]"
        @href_regex = /^(https?:)?\/\//i
        @excluded_hosts = []

        @add_nofollow = true
        @add_noindex = true
        @add_noreferrer = true
        @add_noopener = true
        @del_attrs = true
      end
    end
  end
end
