module Phat
  class TemplateHandler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable
    self.default_format = Mime::JSON

    def compile template
      "Phat::TemplateHandler.process(formats) do
         #{template.source}
       end"
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
