module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_goto_routes

      scope module: 'enjoy' do
        scope module: 'goto' do
          get '/goto/*url' => 'transfers#index', as: :enjoy_goto, format: false
        end
      end

    end

  end
end
