require 'rails/generators'

module Enjoy::Goto::Config
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::Goto Config generator'
    def install
      template 'enjoy_goto.erb', "config/initializers/enjoy_goto.rb"
    end

  end
end
