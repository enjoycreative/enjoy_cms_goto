require 'nokogiri'
require 'addressable'
require 'rack'

module Enjoy::Goto
  class Middleware

    ATTRS = {
      disabled:       'data-enjoy-goto-disabled',
      add_nofollow:   'data-enjoy-goto-add-nofollow',
      add_noindex:    'data-enjoy-goto-add-noindex',
      add_noreferrer: 'data-enjoy-goto-add-noreferrer',
      add_noopener:   'data-enjoy-goto-add-noopener',
      del_attrs:      'data-enjoy-goto-del-attrs'
    }

    REL_ATTRS = ATTRS
    REL_ATTRS.delete(:disabled)

    def initialize(app, options = {})
      @app = app
      self
    end

    def call(env)
      status, headers, body = @app.call(env)

      if headers['Content-Type'].to_s.include?('text/html')
        begin
          doc = Nokogiri::HTML.fragment(body.body)
          doc.css(Enjoy::Goto.config[:css_selector]).each do |a|
            if (!a[ATTRS[:disabled]].blank? and !["0", "false", "no"].include?(a[ATTRS[:disabled]]))
              del_attrs(a)
              next
            end

            _href = a['href']
            if _href =~ Enjoy::Goto.config[:href_regex]
              begin
                _host = Addressable::URI.parse(_href).host
                unless Enjoy::Goto.config[:excluded_hosts].include?(_host)
                  a['href'] = Rails.application.routes.url_helpers.enjoy_goto_path(url: _href)
                  a['target'] = '_blank' if a['target'].blank?
                  set_rel_attribute(a)
                  del_attrs(a)
                end
              rescue
              end
            end
          end
          return [status, headers, [doc.to_html]]
        rescue
        end
      end

      [status, headers, body]
    end

    private
    def check_attr(a, attr_name)
      Enjoy::Goto.config[attr_name] or (!a[ATTRS[attr_name]].blank? and !["0", "false", "no"].include?(a[ATTRS[attr_name]]))
    end

    def add_attr(a, attr_name)
      rel = a['rel'].blank? ? [] : a.rel.split(" ")
      rel << attr_name unless rel.include?(attr_name)
      a
    end

    def add_nofollow(a)
      add_attr('nofollow') if check_attr(a, :add_nofollow)
    end

    def add_noindex(a)
      add_attr('noindex') if check_attr(a, :add_noindex)
    end

    def add_noreferrer(a)
      add_attr('noreferrer') if check_attr(a, :add_noreferrer)
    end

    def add_noopener(a)
      add_attr('noopener') if check_attr(a, :add_noopener)
    end

    def del_attrs(a)
      if check_attr(ATTRS[del_attrs])
        ATTRS.values.each do |attr|
          a.remove_attribute(attr)
        end
      end
    end

    def set_rel_attribute(a)
      REL_ATTRS.keys.each do |meth|
        self.send(meth, a)
      end
    end

  end
end
