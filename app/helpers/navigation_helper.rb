module NavigationHelper
  def render_nav_bar
    active_element = active_nav_element

    content_tag(:ul, :class => 'nav nav-tabs') do
      nav_elements.map do |element|
        is_active = active_element == element[2]
        render_nav_element(*element, is_active)
      end.join.html_safe
    end
  end

  private
  # list of navigation elements
  # format: displayed text, url to link to, id
  # the third element, id, is only used for determining which is active
  def nav_elements
    [
      [t('garments.name').pluralize, garments_path, 'garments'],
      [t('garments.new'), new_garment_path, 'new_garment'],
      [t('garment_types.name').pluralize, garment_types_path, 'garment_types'],
      [t('sales.name').pluralize, sales_path, 'sales']
    ]
  end

  def active_nav_element
    if params[:controller] == 'garments' && params[:action] == 'new'
      'new_garment'
    else
      params[:controller]
    end
  end

  def render_nav_element(text, href, id, is_active)
    options = is_active ? {:class => 'active' } : {}

    content_tag(:li, options) do
      link_to(text, href)
    end
  end
end
