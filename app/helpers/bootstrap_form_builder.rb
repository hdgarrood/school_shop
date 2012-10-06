class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

  private
  def self.create_helper_for(field_type)
    define_method(field_type) do |*args| 
    end
  end

  #field_helpers.each do |name|
  #  create_helper_with_label_for(name)
  #end

  public
  def bootstrap_field(field_type, attr, options = {})
    @template.content_tag(:div, :class => 'control-group') do
      html = ""
      html << label(attr, :class => 'control-label') if options[:with_label]
      html << @template.content_tag(:div, :class => 'controls') do
        send(field_type, attr)
      end
      html.html_safe
    end
  end
end
