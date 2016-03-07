module Enjoy::Goto
  module Models
    module Mongoid
      module Transfer
        extend ActiveSupport::Concern
        include ::Mongoid::Userstamp

        included do
          field :recieved_url,  type: String
          field :url,           type: String
          field :host,          type: String
          field :referer,       type: String
          field :source_ip,     type: String
        end
      end
    end
  end
end
