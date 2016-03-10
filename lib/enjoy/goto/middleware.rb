require 'nokogiri'
require 'addressable'
require 'rack'

module Enjoy::Goto
  class Middleware

    def initialize(app, options = {})
      @app = app
      @excluded_hosts = options.delete(:excluded_hosts) || []
      self
    end

    def call(env)
      status, headers, body = @app.call(env)

      if headers['Content-Type'].to_s.include?('text/html')
        doc = Nokogiri::HTML.parse(body.body)
        doc.css("a[href]").each do |a|
          _href = a['href']
          if _href =~ /^(https?:)?\/\//i
            begin
              _host = Addressable::URI.parse(_href).host
              unless @excluded_hosts.include?(_host)
                a['href'] = Rails.application.routes.url_helpers.enjoy_goto_path(url: _href)
              end
            rescue
            end
          end
        end
        return [status, headers, [doc.to_html]]
      end

      [status, headers, body]
    end
  end
end
