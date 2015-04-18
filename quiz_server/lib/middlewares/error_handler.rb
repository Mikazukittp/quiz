module QuizServer
    class ErrorHandler
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
        @app.call(env)
        rescue Exception
            handle_500
        rescue ActionController::RoutingError
            handle_404
        rescue ActiveRecord::RecordNotFound
            handle_404
        end

      end

      def handle_500
        logger.info "Rendering 500 with exception"
        render :status => 500,
           :json => {:success => false,
                     :info => "Internal Server Error"}
      end

      def handle_404
        logger.info "Rendering 404 with exception"
        render :status => 404,
           :json => {:success => false,
                     :info => "routing error"}
      end
    end
end
