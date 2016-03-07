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

      def initialize
      end
    end
  end
end
