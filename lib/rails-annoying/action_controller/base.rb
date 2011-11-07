module RailsAnnoying
  module ActionController
    # :nodoc:
    def self.included(klass)
      klass.class_eval do
        extend Base
      end
    end

    module Base
      def dont_be_annoying
        ::ActionController::Base.send :include, ClassMethods
      end
    end

    module ClassMethods
      # :nodoc:
      def self.included(klass)
        klass.class_eval do
          # Rescue exceptions with custom error pages in production
          unless Rails.application.config.consider_all_requests_local
            rescue_from ::Exception, :with => :render_error # Generic error (500, etc.)

            rescue_from ::ActionController::InvalidAuthenticityToken, :with => :render_csrf
            rescue_from ::ActiveRecord::RecordNotFound, :with => :render_not_found
            rescue_from ::ActionController::RoutingError, :with => :render_not_found
            rescue_from ::ActionController::UnknownController, :with => :render_not_found
            rescue_from ::ActionController::UnknownAction, :with => :render_not_found
          end

          extend ClassMethods
        end
      end

      def render_csrf(exception)
        logger.info(exception)
        
        render "/errors/csrf", :status => 403
      end
      
      def render_error(exception)
        logger.error(exception)
        
        render "/errors/500", :status => 500
      end
      
      def render_not_found(exception)
        logger.info(exception)
        
        render "/errors/404", :status => 404
      end
    end
  end
end

::ActionController::Base.send :include, RailsAnnoying::ActionController
