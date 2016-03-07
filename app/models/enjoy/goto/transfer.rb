module Enjoy::Goto
  class Transfer
    include Enjoy::Goto::Models::Transfer

    include Enjoy::Goto::Decorators::Transfer

    rails_admin(&Enjoy::Goto::Admin::Transfer.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
