module NavigationHelper
  def render_nav_element(text, href, controller = '')
    css_class = controller == params[:controller] ? 'active' : ''
    content_tag(:li, :class => css_class) do
      link_to(text, href)
    end
  end
end
