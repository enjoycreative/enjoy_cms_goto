require "enjoy/goto/version"

require "enjoy/goto/routes"

# require 'enjoy_cms'

require 'mongoid'
require 'mongoid_userstamp'

require 'enjoy/goto/configuration'
require 'enjoy/goto/engine'
require "enjoy/goto/middleware"

module Enjoy
  module Goto
    class << self
      def orm
        :mongoid #Enjoy.orm
      end
      def mongoid?
        Enjoy::Goto.orm == :mongoid
      end
      def active_record?
        Enjoy::Goto.orm == :active_record
      end
      def model_namespace
        "Enjoy::Goto::Models::#{Enjoy::Goto.orm.to_s.camelize}"
      end
      def orm_specific(name)
        "#{model_namespace}::#{name}".constantize
      end
    end

    autoload :Admin, 'enjoy/goto/admin'
    module Admin
      autoload :Transfer, 'enjoy/goto/admin/transfer'
    end

    module Models
      autoload :Transfer, 'enjoy/goto/models/transfer'

      module Mongoid
        autoload :Transfer, 'enjoy/goto/models/mongoid/transfer'
      end
    end

    module Controllers
      autoload :Transfers, 'enjoy/goto/controllers/transfers'
    end

  end
end
