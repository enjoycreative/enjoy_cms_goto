module Enjoy::Goto
  class TransfersController < ApplicationController
    include Enjoy::Goto::Controllers::Transfers

    include Enjoy::Goto::Decorators::Transfers
  end
end
