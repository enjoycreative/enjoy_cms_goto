module Enjoy::Goto
  module Models
    module Transfer
      extend ActiveSupport::Concern
      include Enjoy::Model

      include Enjoy::Goto.orm_specific('Transfer')

      include ManualSlug

      included do
      end
    end
  end
end
