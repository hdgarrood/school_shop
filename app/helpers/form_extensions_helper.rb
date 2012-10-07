module FormExtensionsHelper
  class ::TwitterBootstrapFormFor::FormBuilder
    #
    # Renders a text field with the current locale's currency unit as a
    # prepended add-on.
    #
    def price_field(attribute, *args)
      options = args.extract_options!
      options = { :add_on => :prepend }.merge(options)

      text_field(attribute, *(args << options)) do
        template.concat template.content_tag(:span,
                                             I18n.t('number.currency.format.unit').html_safe,
                                             :class => 'add-on')
      end
    end
  end
end
