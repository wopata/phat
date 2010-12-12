module Phat
  class TemplateHandler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable
    self.default_format = Mime::JSON

    def compile template
      if template.virtual_path =~ %r(/_[a-z0-9_]+$)
        # Partials should not be serialized..
        template.source
      else
        # ..so they can be called from non-partials.
        "Phat::TemplateHandler.process(formats) do
           #{template.source}
         end"
      end
    end

    class << self
      def process formats, &block
        send "render_#{formats.first}", &block
      end

      def render_xml
        yield.to_xml
      end

      def render_json
        yield.to_json
      end
    end
  end
end
