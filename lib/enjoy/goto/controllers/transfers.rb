module Enjoy::Goto
  module Controllers
    module Transfers
      extend ActiveSupport::Concern

      def index
        url = Addressable::URI.parse(params[:url]) rescue nil
        referer = (request.referer ? Addressable::URI.parse(request.referer) : nil) rescue nil

        @transfer = Transfer.new
        @transfer.recieved_url = params[:url]
        @transfer.url = url.to_s
        @transfer.host = url.host.to_s if url
        @transfer.referer = referer.to_s
        @transfer.source_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
        @transfer.save

        redirect_to @transfer.url, code: 303
      end

    end
  end
end
