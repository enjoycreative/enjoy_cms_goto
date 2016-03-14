module Enjoy::Goto
  module Admin
    module Transfer
      def self.config(fields = {})
        Proc.new {

          field :creator do
            filterable true
            pretty_value do
              unless bindings[:object].creator.blank?
                route = (bindings[:view] || bindings[:controller])
                creator = bindings[:object].creator
                model_name = creator.class.to_param.gsub("::", "~").underscore
                _url = route.rails_admin.show_path(model_name: model_name, id: creator._id)
                route.link_to(creator.name_for_enjoy_cms, _url, class: "creator_link")
              end
            end
          end
          field :created_at
          field :url do
            searchable true
            pretty_value do
              unless bindings[:object].url.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].url).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :recieved_url
          field :host do
            searchable true
            pretty_value do
              unless bindings[:object].host.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].host).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :referer do
            searchable true
            pretty_value do
              unless bindings[:object].referer.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].referer).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :source_ip do
            searchable true
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
