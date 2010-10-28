require 'phat/core_ext'

if defined? Rails
  module Phat
    class Railtie < Rails::Railtie
      config.before_initialize do
        require 'phat/template_handler'
        require 'phat/active_record'
        ActionView::Template.register_template_handler :phat, TemplateHandler
        ::ActiveRecord::Base.send :include, ActiveRecord
      end
    end
  end
end
