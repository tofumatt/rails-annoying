module RailsAnnoying
  module ActionController #:nodoc:
    def self.included(klass) #:nodoc:
      klass.class_eval do
        extend Base
      end
    end

    module Base
      # When called inside any controller that inherits ActionController::Base, modifies
      # the controller (and all controllers decending from it) to recover from CSRF and
      # routing errors, as well as ActiveRecord::RecordNotFound errors sanely.
      #
      # By default rails-annoying renders really basic error pages with some simple
      # info gleamed from the *request* object. If you want to use custom views, just
      # define your own view files in *views/shared/*:
      #
      # views/shared/*error.html*::             Standard error for ISE (500s), etc.
      # views/shared/*error_not_allowed.html*:: 403, 422, and CSRF will use this.
      # views/shared/*error_not_found.html*::   404 will use this.
      #
      # === Writing Custom Handlers
      #
      # The methods used to render errors are ClassMethods#render_csrf,
      # ClassMethods#render_error, and ClassMethods#render_not_found, all defined and
      # handled by rails-annoying, but you can override these methods inside your own
      # ApplicationController (or child controllers) for more fine-grained controller.
      def dont_be_annoying
        ::ActionController::Base.send :include, ClassMethods
      end
    end

    module ClassMethods
      def self.included(klass) #:nodoc:
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
